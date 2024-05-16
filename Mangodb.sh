#!/bin/bash

USERID=$(id -u)
SCRIPT_NAME=$0
DATE=$(date +%F)
LOGDIR=/home/centos/Roboshop
LOGFILE=/$LOGDIR/$SCRIPT_NAME_DATE.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
    then 
    echo -e "$R ERROR:: $N Please try with ROOT USER"
    exit 1
fi    

Validate(){
    if [ $1 -ne 0 ]
     then
         echo -e " $2 ......$R Failure $N"
         Exit 1
        else
         echo -e " $2 ...... $G Success $N"
    fi      
}

cp /home/centos/Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOGFILE
Validate $? "Mongo-repo-copied"
yum install mongodb-org -y &>>$LOGFILE
Validate $? "Mongodb"
systemctl enable mongod &>>$LOGFILE
Validate $? "enabling mongoDB"
systemctl Start mongod &>>$LOGFILE
Validate $? "Starting mongoDB"
sed -i 's/127.0.0.1/0.0.0.0' /etc/mongod.conf &>>$LOGFILE
Validate $? "Accepting public entry"
systemctl restart mongod &>>$LOGFILE
Validate $? "Restart mongoDB"


