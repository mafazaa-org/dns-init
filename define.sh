#!/bin/bash

# make sure user running this script as root
if [ "$EUID" -ne 0 ]
  then echo "Please run the script as root"
  exit
fi

# get server variables
echo "branch [dev, test, prod]:"
read branch
echo "level [high, low]:" 
read level
echo "server [primary, secondary]:"
read server

# setup env variables
home=/home/dns-admin

# save variables to .bashrc
echo export branch=$branch >> $home/.bashrc
echo export level=$level >> $home/.bashrc
echo export server=$server >> $home/.bashrc

source $home/.bashrc

# setup crtonab jobs

crontab_file=/var/spool/cron/crontabs/dns-admin

## setup crontab env variables
echo level=$level >> $crontab_file
echo branch=$branch >> $crontab_file
echo server=$server >> $crontab_file

## setup up jobs that shall use these variables
echo "~ ~ 0-31/3 * * $home/dns-init/update.sh" >> $crontab_file
echo "0 0 0-31/10 * * rm $home/.dns-logs" >> $crontab_file

## change the hostname of the server
server_name=$server-$level-dns.mafazaa.com

hostname $server_name

echo $server_name > /etc/hostname

echo "127.0.0.1 $server_name" >> /etc/hosts

# changing the password for the dns-admin

echo "change default dns-admin password? (y/n)"
read change
if [ $change ]; then
  passwd dns-admin
fi

# deleting the ubuntu user

if [ $(cat /etc/passwd | grep ubuntu) ]; then
  deluser --remove-home ubuntu
fi

touch $home/.dns-logs

chown dns-admin $home/.dns-logs

$home/dns-init/update.sh

echo we have changed your hostname, to see changes, exit and login again
read