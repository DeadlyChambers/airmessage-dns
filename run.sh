#!/bin/bash
_domain_name="<the domain name>"
_hosted_zone="<the aws host zone>"
_profile="<iam user creds>"
script_dir=$(dirname "$0")
cd $script_dir
rm -rf output.log
touch output.log
echo "start ${date}" > output.log
_current_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
_recent_ip=$(dig +short "$_domain_name")
echo $_current_ip >> output.log
echo $_recent_ip >> output.log
if [ "$_recent_ip" == "$_current_ip" ] ;
    then
		echo "They are the same" >> output.log
    else
		sed "s|_new_ip|${_current_ip}|; s|_aws_domain_name|${_domain_name}|" change-template.json > change-resource-record-sets.json
		aws route53 change-resource-record-sets --hosted-zone-id $_hosted_zone --change-batch "file://change-resource-record-sets.json" --profile $_profile
		cat change-resource-record-sets.json >> output.log
fi
cd -