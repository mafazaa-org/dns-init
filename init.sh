#!/bin/bash

## installing python and pip
cd ~/

echo
echo updating packages
sudo apt update

echo
echo installing python and pip
sudo apt install python3 python3-pip -y

# setting repos environment variables

export DNS_REPOS_ROOT=https://github.com/mafazaa-org
export DNS_INIT=dns-init
export DNS_SERVER=dns-server
export DNS_CHECK=dns-check
export DNS_IP_CONFIRM=dns-ip-confirm

echo export DNS_REPOS_ROOT=$DNS_REPOS_ROOT >> ~/.bashrc
echo export DNS_INIT=$DNS_INIT >> ~/.bashrc
echo export DNS_SERVER=$DNS_SERVER >> ~/.bashrc
echo export DNS_CHECK=$DNS_CHECK >> ~/.bashrc
echo export DNS_IP_CONFIRM=$DNS_IP_CONFIRM >> ~/.bashrc

source ~/.bashrc

crontab_file=/var/spool/cron/crontabs/dns-admin

echo DNS_REPOS_ROOT=$DNS_REPOS_ROOT >> $crontab_file
echo DNS_INIT=$DNS_INIT >> $crontab_file
echo DNS_SERVER=$DNS_SERVER >> $crontab_file
echo DNS_CHECK=$DNS_CHECK >> $crontab_file
echo DNS_IP_CONFIRM=$DNS_IP_CONFIRM >> $crontab_file

echo 0 0 0 0-30/10 * rm /home/dns-admin/.dns-logs

## setup dns-admin user

sudo useradd dns-admin --no-user-group --shell /bin/bash --home-dir /home/dns-admin
sudo mkdir /home/dns-admin

echo please add the user dns-admin to the sudoers file

read

sudo visudo

sudo cp ~/.ssh /home/dns-admin/.ssh

sudo chown -hR dns-admin /home/dns-admin/.ssh

sudo git clone $DNS_REPOS_ROOT/$DNS_INIT /home/dns-admin/dns-init

echo the next time, login with dns-admin so the script can delete the first user

read

## freeing port 53

echo 
echo uncomment DNS and DNSStubListener and change them to {your.Dns.Server.ip} and no respectively
echo 
echo press enter to continue
read

sudo nano /etc/systemd/resolved.conf

echo 
echo assuming you did it we are creating a soft link now!

sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

echo
echo congratulations, now we are going to shutdown the system
echo 

echo "shutdown now? (y/n)"
read shutdown_now

if [ shutdown_now == "y" ]; then
    sudo shutdown -h now
fi