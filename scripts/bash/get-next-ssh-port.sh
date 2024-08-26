#!/bin/bash
# Author SIVARAAM
# Email : sivaraam73@yahoo.com
# If you have a directory full of  files or even a git repo directory that contains constantly updated SSH config,
# You can use this script to get the next available SSH Port without any confilct

function get_ssh_port(){

clear;echo;echo

echo " __   _ _______ _     _ _______      _______ _______ _     _       _____   _____   ______ _______"
echo " | \  | |______  \___/     |         |______ |______ |_____|      |_____] |     | |_____/    |   "
echo " |  \_| |______ _/   \_    |         ______| ______| |     |      |       |_____| |    \_    |   "


echo;echo

# Set work directory
WORK_DIR="~/work-dir"

# Update Git Repo
cd ~/git-repo/
git pull

# Set SSH_PORT to grep port number from gateways dir, sort highest to lowest, get first port
# You can get rid of ' --exclude=$WORK_DIR/excluded-file-if-any  ' if you do not have any exclusion

SSH_PORT=$(grep -rI --exclude=$WORK_DIR/excluded-file-if-any 'port: ' $WORK_DIR/* | cut -d':' -f3 | sort -rn | head -n 1)

echo;echo

# Add 1 to current highest port to give new ssh port
NEXT_SSH_PORT=$(($SSH_PORT+1))

echo "Next Available SSH Port Is : $NEXT_SSH_PORT"
echo;echo

sleep 7s
break

}
