If you are running a custom implementation of Airmessage and you have a domain in 
Route 53 with an Alias record that is pointing to your IP address. Update a few
Values to reflect your aws account, local credentials, and local Mac configuration 
to create a service that will use launchd to ensure the
Alias record is updated when your public up is changed. 

# Setting up a job with launchctl on mac
Assuming you have copied all of these files over to ~/scripts folder. You will
want to ensure you update the com.airmessage.dns file to your liking. Replace 
youruser with your actual user. Then ensure you have the ~/.aws/Credentials file 
loaded with the user you will want to the aws cli as.
You will need to update the dnsupdate.sh script to have the proper values denoted
with angle brackets.
You can run the start command below, or you can log out and log back in. If the
service file is in the ~/Library/LaunchAgents directory it will start up

## Setup the service
First you put the plist file into your user library launch agent directory
and make sure the directory has the right privs for any scripts you
use or logs your write.

```
cp ~/scripts/com.airmessage.dns.plist ~/Library/LaunchAgents/
chmod +rx ~/scripts/*.sh
chmod +rw ~/scripts/*.log
chmod +rw ~/scripts/*.json
launchctl start com.airmessage.dns
```

Depending on the interval used, you will see the log files appear in your
scripts directory. You can also see the logs in the mac Console. That is
is under system utilites, not the terminal.

```
tail -10 ~/scripts/stdout.log
```

## Updating the service
If for some reason you need to make a change to the service itself you will need
to stop the service, and update the file, and start the service.
After you have ran the start launchctl start command, you should see logs

```
launchctl stop com.airmessage.dns
nano com.airmessage.dns.plist
cp com.airmessage.dns.plist ~/Library/LaunchAgents/ && launchtl start com.airmessage.dns

# to restart
launchctl start com.airmessage.dns

# to remove the service completely
launchctl boutout user/com.airmessage.dns 
# you could also rm ~/Library/LaunchAgents/com.airmessage.dns.plist
```

Then boom, you should have your service running. Now these logs are being put
into the file called out in the service for output and error directories.

## Logging and Cleanup
So I actually threw in another service that cleans up the logs every day.

```
cp com.airmessage.logs ~/Library/LaunchAgents/
launchctl bootstrap user/com.airmessage.logs
```

Then it is a matter of repeating the same process as above but for the other service
