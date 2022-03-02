Basics
===========================
You will need to pass the domain name, and the hosted zone as parameters to the run.sh script after ensuring the script can be executed
```
chmod +x run.sh
./run.sh airmessage.domain.com EXAMPLE123HOSTEDZONE
```

Setting either a windows job to run this, or a cron job to run every 45 minutes should ensure your dynamic dns is covered

## Security
You should be able to create an IAM user, with access keys, that can ONLY change-resource-record-sets in route 53 for the specific zone. Then
put those creds on your airmessage server.
