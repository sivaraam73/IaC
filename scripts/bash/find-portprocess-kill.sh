# Release Stale SSH Port
# Author : Sivaraam
# Email : sivaraam73@yahooo.com

# Use this script to find out which process is using a particular PID and kill it

#!/bin/bash

function release_connectedport(){
clear;echo;echo
echo "  ______ _______ _______ _______ _______       _____   ______  _____  _______ _______ _______ _______"
echo " |_____/ |______ |______ |______    |         |_____] |_____/ |     | |       |______ |______ |______"
echo " |    \_ |______ ______| |______    |         |       |    \_ |_____| |_____  |______ ______| ______|"
echo;echo
read -p "Enter Port To Release Stale Connection..: " CONNECTION_PORT
KILL_PID=`sudo netstat -alpn | grep "$CONNECTION_PORT" | grep sshd | awk '{print $7}' | cut -d '/' -f1 | tail -1`

#echo "$KILL_PID"
echo
printf "Kill process ??  (y/n)? "
echo
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
  sudo kill -9 $KILL_PID
  echo
  echo "Process Terminated..."
else
  echo
  echo "Exiting program ... "
  sleep 1s
  break;clear
fi
echo;echo
break
}
release_connectdport
