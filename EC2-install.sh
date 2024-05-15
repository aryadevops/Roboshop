#!?bin/bash

Names=("web" "mongodb" "user" "cart" "catalogue" "reddis" "rabbitmq" "mysql" "shiiping" "paymet" "dispatch")
INSTANCE_TYPE=" "
IMAGE_ID="ami-0f3c7d07486cad139"
SECURITY_GROUP_ID="sg-0b06e05c2dbc1d866"
#DOMAIN_NAME=
#HOSTED_ZONE=
   



for i in "${Names[@]}"
do
  if [[ $i == "mongodb" || $i == "mysql" ]]
  then
   INSTANCE_TYPE="t3.medium"
   else
   INSTANCE_TYPE="t2.micro"
  fi

  echo "Creating $i Instance"
 Private_ip=$(aws ec2 run-instances --image-id $IMAGE_ID  --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" | jq -r '.Instances[0].PrivateIpAddress')
 echo "Created $i Instance: $Private_ip"
done      