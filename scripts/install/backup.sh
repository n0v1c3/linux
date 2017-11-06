#!/bin/bash

# Name: backup.sh
# Description: 

# =======
# Backups
# =======

# Local backup (no delete)
sudo rsync --archive /home /backups/localhost

# Network backup (with delete) when connected
if [ "$(mount | grep /mnt/tjg/dlink)" ]
then
    sudo rsync --archive --delete -e ssh /home /mnt/tjg/dlink/backups/$(hostname)
fi

# ====
# Exit
# ====

# Successful execution
exit 0
