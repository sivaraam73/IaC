#!/bin/bash

#================   Set required hosts in /etc/hosts  =======================
sudo su -c "echo 'ip1     host1.domain.local' >> /etc/hosts"
sudo su -c "echo 'ip2     host1.domain.loca2' >> /etc/hosts"



#================   Setup and install required packages  =======================

sudo su -c 'dnf install epel-release -y'
sudo su -c 'dnf install https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm -y'
sudo su -c 'dnf update -y'
sudo su -c 'dnf install net-tools wget curl zip unzip -y;dnf install bind-utils -y;dnf module enable idm:DL1 -y;dnf distro-sync -y;dnf module install idm:DL1/client -y;dnf install ipa-client -y'
sudo su -c 'dnf install python3 -y'
sudo su -c 'dnf makecache'


#================   Set SSH config  =================================

# Generic SSHD Config

- sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
- sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
- sed -i 's/#PasswordAuthentication no/PasswordAuthentication no/g' /etc/ssh/sshd_config
- sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
- sed -i 's/#ChallengeResponseAuthentication no/ChallengeResponseAuthentication no/g' /etc/ssh/sshd_config
- sed -i 'AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys' /etc/ssh/sshd_config
- sed -i 'AuthorizedKeysCommandUser nobody' /etc/ssh/sshd_config
- sed -i 's/#AllowAgentForwarding yes/AllowAgentForwarding yes/g' /etc/ssh/sshd_config
- sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
- sed -i 's/#UsePAM no/UsePAM yes' /etc/ssh/sshd_config
- sed -i 's/#GSSAPIAuthentication no/GSSAPIAuthentication yes' /etc/ssh/sshd_config


#==============   Set salt master location and start minion   ===================
sudo su -c 'dnf install salt-minion -y'
sudo su -c "sed -i 's/#master: salt/master: salt-master/' /etc/salt/minion"
sudo su -c 'systemctl enable salt-minion'
sudo su -c 'systemctl start salt-minion'
sleep 3m


#===============  Setup and install IPA CLIENT =============================
ETH1=$(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1)


#==============  Enrol Machine in IPA =======================
sudo su -c "ipa-client-install -U\
--principal=admin --password=password \
--hostname=$HOSTNAME --ip-address=$ETH1 --unattended \
--enable-dns-updates \
--no-ntp --mkhomedir --server=server-fqdn \
--domain DOMAIN --realm REALM"

