#!/bin/bash
_domain_name="<enter the dns route that forwards to your ip>"
_hosted_zone="<hosted aws zone"
_curdate=$(date +"%D %r")
_current_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
_recent_ip=$(dig +short "$_domain_name")
if [ "$_recent_ip" == "$_current_ip" ] ;
    then
		echo -e "${_curdate} - Same"
    else
		sed "s|_new_ip|${_current_ip}|; s|_aws_domain_name|${_domain_name}|" change-template.json > change-resource-record-sets.json
		aws route53 change-resource-record-sets --hosted-zone-id $_hosted_zone --change-batch "file://change-resource-record-sets.json" --profile <Aws Profile in Cred File>	
		echo -e "${_curdate} - ${_recent_ip} -> ${_current_ip}"
fi

