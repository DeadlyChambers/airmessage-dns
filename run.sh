#!/bin/bash
if [ -z "$1" ] ; then read "what domain are you using in aws" _domain_name; else _domain_name="$1"; fi
if [ -z "$2" ] ; then read "what hosted zone are you using in aws" _hosted_zone; else _hosted_zone="$2"; fi

_current_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
_recent_ip=$(dig +short "$_domain_name")
echo $_current_ip
echo $_recent_ip
if [ "$_recent_ip" == "$_current_ip" ] ;
    then
	 echo "They are the same"
    else
	sed "s/_new_ip/${_current_ip}/; s/_aws_domain_name/${_domain_name}/" change-template.json > change-resource-record-sets.json
	aws route53 change-resource-record-sets --hosted-zone-id $_hosted_zone --change-batch file://change-resource-record-sets.json
	cat change-resource-record-sets.json
fi


