#! /bin/sh

### Installs the Userify (userify.com) shim ###
# This installer does the following:
# 1. Create /opt/userify and credentials file in it (creds.py)a
# 2. Patch /etc/rc.local (/etc/init.d/after.local on SUSE) with a link to the daemon
# 3. Creates an uninstall script at /opt/userify/uninstall.sh
# 4. Kicks off shim.py every 90 seconds (only one shim will run at a time)

curl -k "https://shim.userify.com/installer.sh" | api_id="### USERIFY API ID ###" api_key="### USERIFY API KEY ###" sudo -sE
