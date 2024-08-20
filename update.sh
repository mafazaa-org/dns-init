#!/bin/bash

## updating dns repos

HOME=/home/dns-admin
LOG_FILE=$HOME/.dns/logs

echo updating dns repos at $(date) >> $LOG_FILE

cd $HOME

for repo in $DNS_CHECK $DNS_INIT $DNS_IP_CONFIRM $DNS_SERVER;
do
    # go to that repo, fetch latest updates, update current version to it, and finally enable execution
    if [ $(ls | grep $repo) ]; then
        echo repo $repo exists, updating it at $(date) >> $LOG_FILE
        cd $repo
        git fetch --all
        git reset --hard origin/$branch
        chmod +x *
        echo updated $repo at $(date) >> $LOG_FILE
    else
        echo repo $repo do not exist, cloning it at $(date) >> $LOG_FILE
        git clone $DNS_REPOS_ROOT/$repo -b $branch
        echo cloned $repo at $(date) >> $LOG_FILE
    fi

    # if the repo has an update script, run it
    if [ $(ls | grep post_update.sh) ]; then
        echo post updating for $repo at $(date) >> $LOG_FILE
        ./post_update.sh
        echo dons post updating for $repo
    fi

    # go back to user directory
    cd $HOME

done

echo done task at $(date) >> $LOG_FILE