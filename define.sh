echo "branch [dev, test, prod]:"
read branch
echo "level [high, low]:" 
read level
echo "server [primary, secondary]:"
read server

home=/home/dns-admin

export branch=$branch
export level=$level
export server=$server


echo export branch=$branch >> $home/.bashrc
echo export level=$level >> $home/.bashrc
echo export server=$server >> $home/.bashrc

source $home/.bashrc

crontab_file=/var/spool/cron/crontabs/dns-admin

echo level=$level >> $crontab_file
echo branch=$branch >> $crontab_file
echo server=$server >> $crontab_file

echo 00 0~2 * * * $home/dns-init/update.sh

sudo hostname $server-$level-dns.mafazaa.com
