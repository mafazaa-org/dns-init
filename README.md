# mafazaa dns init

A repo containing the scripts to initialize a server and prepare it for running the dns server

## Usage

just give the permission to execute the scripts using this command

```shell
chmod +x init.sh
```

then simply run the init script

```shell
./init.sh
```

this script sets the update script to run on startup and clone the repos but if you want to do it yourself, you can run it like that

```shell
./update.sh
```

## What the scripts does

-   installs python3 and pip3
-   free port 53 from systemr
