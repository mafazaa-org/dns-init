#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run the script as root"
  exit
fi

## installing python and pip

echo
echo updating packages
apt update

echo
echo installing python and pip
apt install python3 python3-pip -y

## setting up repos environment variables

export DNS_REPOS_ROOT=https://github.com/mafazaa-org
export DNS_INIT=dns-init
export DNS_SERVER=dns-server
export DNS_CHECK=dns-check
export DNS_IP_CONFIRM=dns-ip-confirm

## setup dns-admin user

old_home=/home/ubuntu

username=dns-admin

home=/home/$username

echo ATTENTION
echo username dns-admin will be created right now with the default password dns-admin
echo press enter to continue...

useradd -p $(perl -e 'print crypt($ARGV[0], "password")' 'dns-admin') -m $username -s /bin/bash

echo "$username ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "added dns-admin to sudoers file, do you want to edit the sudoers file?"
read edit
if [ $edit ]; then
  visudo
fi


cp $old_home/.ssh $home/.ssh -r

chown -hR $username $home/.ssh

cp $old_home/$DNS_INIT $home/$DNS_INIT -r

chown -hR $username $home/$DNS_INIT


echo the next time, login with $username

read

# adding env to variables

echo export DNS_REPOS_ROOT=$DNS_REPOS_ROOT >> $home/.bashrc
echo export DNS_INIT=$DNS_INIT >> $home/.bashrc
echo export DNS_SERVER=$DNS_SERVER >> $home/.bashrc
echo export DNS_CHECK=$DNS_CHECK >> $home/.bashrc
echo export DNS_IP_CONFIRM=$DNS_IP_CONFIRM >> $home/.bashrc


crontab_file=$username

touch $crontab_file

echo DNS_REPOS_ROOT=$DNS_REPOS_ROOT >> $crontab_file
echo DNS_INIT=$DNS_INIT >> $crontab_file
echo DNS_SERVER=$DNS_SERVER >> $crontab_file
echo DNS_CHECK=$DNS_CHECK >> $crontab_file
echo DNS_IP_CONFIRM=$DNS_IP_CONFIRM >> $crontab_file

cp $crontab_file /var/spool/cron/crontabs/

## freeing port 53

echo 
echo uncomment DNS and DNSStubListener and change them to 'primary_server_ip,secondary_server_ip' and no respectively
echo 
echo press enter to continue
read

nano /etc/systemd/resolved.conf

echo 
echo assuming you did it we are creating a soft link now!

ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

echo
echo congratulations, now we are going to shutdown the system
echo 

echo "shutdown now? (y/n)"
read shut

if [ $shut == "y" ]; then
    shutdown -h now
fi
