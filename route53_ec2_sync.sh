#!/bin/bash

# Replace with your Fully Qualified Domain Name
domainName = 'ec2-ub9.yourdomain.com'

# Replace with yout Route 53 hosted zone id / Check readme to know your hosted-zone-id
hostedZoneId = 'Z3XXXXXXXXXXT'

# Path to working directory, Eg: workingDir = /home/ubuntu
workingDir = /path/to/working/dir

# Naming the json file, containing A record updates
fileName = 'route53Updates.json'

#  Following dig (domain information groper) command will store your ec2's public ip in publicIP variable
publicIP = "$(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com)"

# Removes the existing updates json file
removeFile = "$(rm ${workingDir}/$fileName)"

# Creates the json file with the A record data with new public IP
echo "{" >>${workingDir}/$fileName
echo "    \"Comment\": \"Update record to reflect new IP address of EC2 instance\"," >>${workingDir}/$fileName
echo "    \"Changes\": [" >>${workingDir}/$fileName
echo "        {" >>${workingDir}/$fileName
echo "            \"Action\": \"UPSERT\"," >>${workingDir}/$fileName
echo "            \"ResourceRecordSet\": {" >>${workingDir}/$fileName
echo "                \"Name\": \"$domainName.\"," >>${workingDir}/$fileName
echo "                \"Type\": \"A\"," >>${workingDir}/$fileName
echo "                \"TTL\": 300," >>${workingDir}/$fileName
echo "                \"ResourceRecords\": [" >>${workingDir}/$fileName
echo "                    {" >>${workingDir}/$fileName
echo "                        \"Value\": $publicIP" >>${workingDir}/$fileName
echo "                    }" >>${workingDir}/$fileName
echo "                ]" >>${workingDir}/$fileName
echo "            }" >>${workingDir}/$fileName
echo "        }" >>${workingDir}/$fileName
echo "    ]" >>${workingDir}/$fileName
echo "}" >>${workingDir}/$fileName

# Pushing the updates file using aws command line interface
# If you don't have awscli, run "sudo apt-get install awscli" then "aws configure"
aws route53 change-resource-record-sets --hosted-zone-id $hostedZoneId --change-batch file://${workingDir}/$fileName

# Enter any other commands below which need to be run on bootup
