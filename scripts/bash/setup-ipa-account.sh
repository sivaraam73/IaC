#!/bin/bash
# Author : SIVARAAM
# Email : sivaraam73@yahoo.com
# 2023
# Use this script to setup an IPA Account and join the account to a group


export TERM=xterm

clear
echo;echo

function create_ipa_account() {

clear;echo

echo " _____  _____  _______      _______  _____  __   _ _______ _____  ______ _     _  ______ _______ _______ _____  _____  __   _"
echo "   |   |_____] |_____|      |       |     | | \  | |______   |   |  ____ |     | |_____/ |_____|    |      |   |     | | \  |"
echo " __|__ |       |     |      |_____  |_____| |  \_| |       __|__ |_____| |_____| |    \_ |     |    |    __|__ |_____| |  \_|"

echo;echo

read -p "Enter firstname: " firstname
echo
read -p "Enter lastname: " lastname
echo
username="${firstname}-${lastname}"
email="${firstname}.${lastname}@domain.com"
group1="group_name"
read -p "Enter SSH Public Key To Add: " sshkey

# Create IPA User Account
echo;echo
echo "Creating & Adding IPA Account...."
ipa user-add "${username}" --first="${firstname}" --last="${lastname}" --email="${email}"

# Setting Password for this IPA Account
echo;echo
echo "Setting Password For This IPA Account...."
sudo -i echo -e "password\npassword" | ipa passwd "${username}"
echo

# Add User-Specified ssh-key to new account
echo;echo
echo "Setting Account SSH Public Key...."
pressh="command=\"echo 'SSH-Remote tunnel only.'\",no-pty,no-x11-forwarding " # can be used to set anything in front of your key
pressh+="${sshkey}"
ipa user-mod "${username}" --sshpubkey="${pressh}"
echo
sleep 2s

# Adding User to customer_account group
echo;echo
echo "Setting Account Into  Group:  customer_project ...."
ipa group-add-member customer_project --users="${username}" --groups=customer_project
echo

sleep 6s
break

}
