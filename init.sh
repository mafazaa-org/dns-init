## installing python and pip
cd ~/

echo
echo updating packages
sudo apt update

echo
echo installing python and pip
sudo apt install python3 python3-pip -y

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
read

# setting repos environment variables

export DNS_REPOS_ROOT=https://github.com/mafazaa-org/
export DNS_INIT=dns-init
export DNS_SERVER=dns-server
export DNS_CHECK=dns-check
export DNS_IP_CONFIRM=dns-ip-confirm

echo export DNS_REPOS_ROOT=https://github.com/mafazaa-org/ >> ~/.bashrc
echo export DNS_INIT=dns-init >> ~/.bashrc
echo export DNS_SERVER=dns-server >> ~/.bashrc
echo export DNS_CHECK=dns-check >> ~/.bashrc
echo export DNS_IP_CONFIRM=dns-ip-confirm >> ~/.bashrc

source ~/.bashrc

sudo shutdown -h now