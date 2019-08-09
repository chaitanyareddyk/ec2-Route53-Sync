## Updating Route 53 A record with the new public ip of AWS ec2, everytime it boots up

### How to use:

- SSH into your ec2 instance.
- Open crontab from terminal
  `crontab -e`
- Choose your favourite text editor, if asked
- Add the following line,
  `@reboot /path/to/script`
  Eg: @reboot /home/ubuntu/route53_ec2_sync.sh
- Save and close the editor.

### How to get your hosted zone ID

- Get aws cli, if you didn't already `sudo apt-get install awscli`
- Configure aws cli with your credentials, `aws configure`
- To know your hosted zone id run this command, `aws route53 list-hosted-zones`
- Everything in the line after “Id”: “/hostedzone/is-your-hosted-zone-ID"
- Copy this hosted zone ID to "hostedZoneId" variable in script file
