#!/bin/bash
clear
echo "make sure you got your script"
sleep 5

cd /etc/systemd/system/

echo "user name:"
read varname
USER=$varname

echo "path:"
read varname
PATH=$varname

echo "description:"
read varname
DESCRIPTION=$varname

echo "service name, end with .service:"
read varname
SERVICE=$varname

touch $SERVICE
echo '[Unit]
Description='$DESCRIPTION'

[Service]
Type=simple

User='$USER'
ExecStart='$PATH'

[Install]
WantedBy=multi-user.target' > $SERVICE

systemctl start $SERVICE
systemctl enable $SERVICE

echo "restart the computer, and look for your program in htop"

#Restart=always
#RestartSec=1
#StartLimitIntervalSec=0
