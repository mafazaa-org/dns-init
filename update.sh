## updating dns repos

echo updating dns repos

cd ~/

for repo in $DNS_CHECK $DNS_INIT $DNS_IP_CONFIRM $DNS_SERVER;
do
    # go to that repo, fetch latest updates, update current version to it, and finally enable execution
    if [ $(ls | grep $repo) ]; then
        echo repo $repo exists, updating it 
        cd $repo
        git fetch --all
        git reset --hard origin/$branch
        chmod +x *
    else
        echo repo $repo do not exist, cloning it
        git clone $DNS_REPOS_ROOT/$repo -b $branch
    fi

    # if the repo has an update script, run it
    if [ $(ls | grep post_update.sh) ]; then
        echo post updating
        ./post_update.sh
    fi

    # go back to user directory
    cd ~/

done