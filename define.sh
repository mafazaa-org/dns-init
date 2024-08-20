echo "branch [dev, test, prod]:"
read branch
echo "level [high, low]:" 
read level
echo "server [primary, secondary]:"
read server

export branch=$branch
export level=$level
export server=$server


echo export branch=$branch >> ~/.bashrc
echo export level=$level >> ~/.bashrc
echo export server=$server >> ~/.bashrc

source ~/.bashrc

sudo rm /etc/init.d/dns_define