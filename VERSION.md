# v1.1.0-beta

## define.sh

-   adds env variables, and update.sh to crontab

## init.sh

-   adds env variables to crontab
-   asks user before shutdown
-   set a crontab script to rm log file every ten days

## update.sh

-   logs to .dns-logs file
-   checks if branch env variable exists first
-   fixes the hostname every time it runs
