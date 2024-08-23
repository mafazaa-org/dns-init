#!/bin/bash

## updating dns repos

HOME=/home/dns-admin
LOG_FILE=$HOME/.dns-logs

echo $(date) : dns-update : INFO :  updating dns repos >> $LOG_FILE

if [ $branch ]; then
    echo $(date) : dns-update : INFO :  found branch environment variable >> $LOG_FILE
else
    echo $(date) : dns-update : FATAL :  cannot find branch env variable >> $LOG_FILE
    exit 1
fi

cd $HOME

for repo in $DNS_CHECK $DNS_INIT $DNS_IP_CONFIRM $DNS_SERVER;
do
    # go to that repo, fetch latest updates, update current version to it, and finally enable execution
    if [ $(ls | grep $repo) ]; then
        echo $(date) : dns-update : INFO :  repo $repo exists, updating it >> $LOG_FILE
        cd $repo
        git fetch --all
        git reset --hard origin/$branch
    else
        echo $(date) : dns-update : INFO :  repo $repo do not exist, cloning it >> $LOG_FILE
        git clone $DNS_REPOS_ROOT/$repo -b $branch
    fi
    chmod +x *
    # if the repo has an update script, run it
    if [ $(ls | grep post_update.sh) ]; then
        echo $(date) : dns-update : INFO :  post updating for $repo >> $LOG_FILE
        ./post_update.sh
    fi

    # go back to user directory
    cd $HOME

done

echo $(date) : dns-update : INFO :  done task  >> $LOG_FILE