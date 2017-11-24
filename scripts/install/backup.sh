#!/bin/bash

# Name: backup.sh
# Description:

# TODO-TJG [171114] - Clean-up method required
# Local backup (no delete)
sudo rsync --info=progress2 --archive /home /backups/localhost

# Network backup (with delete) when connected
if [ "$(mount | grep /mnt/tjg/dlink)" ]; then
    sudo rsync --info=progress2 --delete -a -e ssh /home /mnt/tjg/dlink/backups/"$(hostname)"
fi
exit 0
