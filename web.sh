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

yum install nginx -y &>>$LOGFILE
Validate $? "Installing Nginx"
systemctl enable nginx &>>$LOGFILE
Validate $? "Enableling nginx"
systemctl start nginx &>>$LOGFILE
Validate $? "Starting nginx"
rm -rf /usr/share/nginx/html/* &>>$LOGFILE
Validate $? "Removing Content"
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>>$LOGFILE
Validate $? "Downloading web"
cd /usr/share/nginx/html &>>$LOGFILE
Validate $? "Copying html file"
unzip /tmp/web.zip &>>$LOGFILE
Validate $? "unziping web file"
cp /home/centos/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$LOGFILE
Validate $? "Copying robosho.conf file"
systemctl restart nginx  &>>$LOGFILE
Validate $? "Restarting nginx"