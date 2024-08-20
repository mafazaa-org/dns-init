# CHANGELOG

## v1

### update.sh (NEW)

-   updates all repos or clone them if they don't exist
-   respect the branch environment variable
-   runs post_update script if found

### define.sh (NEW)

-   sets the environment variables branch, level and server
-   adds them to bashrc
-   removes itself from running at startup

### post_update.sh (NEW)

-   adds the new updated update script to startup

### init.sh

-   sets repos names as environment variables
-   adds them to bashrc
-   setup update.sh and define.sh to run at startup

## v0

### init.sh

-   installs python and pip
-   frees port 53 from system-r
