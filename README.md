Basics
===========================
You will need to pass the domain name, and the hosted zone as parameters to the run.sh script after ensuring the script can be executed
```
chmod +x run.sh
```

Set up a job to run every few minutes or hours should ensure your dynamic dns is covered. Not sure how often the ISP(?) changes the IP

## Security
You should be able to create an IAM user, with access keys, that can ONLY change-resource-record-sets in route 53 for the specific zone. Then
ensure the job can use those creds.
