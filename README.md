# mafazaa dns init

A repo containing the scripts to initialize a server and prepare it for running the dns server

## Usage

just give the permission to execute the scripts using this command

```shell
chmod +x init.sh
```

then simply run the init script, and it should print a lot of stuff then the next scenario:

```shell
./init.sh

...alot

uncomment DNS and DNSStubListener and change them to 'primary_server_ip,secondary_server_ip' and no respectively

press enter to continue

```

when you press enter a file will open and if you scroll down a little bit you should see something like this:

```conf
#DNS=
#FallbackDNS=
#Domains=
#DNSSEC=no
#DNSOverTLS=no
#MulticastDNS=no
#LLMNR=no
#Cache=no-negative
#CacheFromLocalhost=no
#DNSStubListener=yes
#DNSStubListenerExtra=
#ReadEtcHosts=yes
```

you should uncomment the fields dns and dnsstublistener, for DNS type your two dns servers sperated dby comma and stublistener should be no. the file should look like this:

```conf
DNS=208.67.222.222,208.67.220.220
#FallbackDNS=
#Domains=
#DNSSEC=no
#DNSOverTLS=no
#MulticastDNS=no
#LLMNR=no
#Cache=no-negative
#CacheFromLocalhost=no
DNSStubListener=no
#DNSStubListenerExtra=
#ReadEtcHosts=yes
```

after that, the script will ask you to shutdown, because the changes made are not simple, I personally saves this image to my ec2 AMI templates as dns-init

after you reboot your instance, some configurations should be done for the server to work as expected, define.sh will do the job if you run it as root. this script will prompt you for the branch, level and server variables! you should experience somthing like this example below

```shell
./define.sh
branch [dev, test, prod]
dev
level [high, low]
high
server [primary, secondary]
primary
```

this script sets the update script to run on startup and clone the repos but if you want to do it yourself, you can run it like that

```shell
./update.sh
```
