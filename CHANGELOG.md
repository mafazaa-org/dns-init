# CHANGELOG

## v1.0.2

### define.sh

-   runs update.sh correctly

## v1.0.1

### init.sh

-   asks the user if he wants to edit the sudoers file manually before doing it

## v1

### init.sh

-   must run as root
-   adds env variables to bashrc and crontab
-   adds the user dns-admin with the password 'dns-admin' and adds him to sudoers file
-   copy the ssh keys to dns-admin home directory to enable logging in as dns-admin

### define.sh (NEW)

-   must run as root
-   sets the environment variables branch, level and server
-   adds env variables, and update.sh to .bashrc and crontab
-   runs the update script and sets it to run every three days
-   change the password for dns-admin
-   change hostname

### update.sh (NEW)

-   logs to .dns-logs file
-   checks if branch env variable exists first
-   fixes the hostname every time it runs
-   updates all repos or clone them if they don't exist
-   respect the branch environment variable
-   runs post_update script if found
-   removes the user ubuntu from the machine

### post_update.sh (NEW)

-   adds the new updated update script to startup

## v0

**Initial release**

### init.sh

-   installs python and pip
-   frees port 53 from system-r
