#!/bin/bash

# Name: backup.sh
# Description:

# Network backup (with delete) when connected
if [ "$(mount | grep /mnt/tjg/dlink)" ]; then
    #sudo rsync --info=progress2 \
    sudo rsync
    --delete -a \
    -e ssh /home /mnt/tjg/dlink/backups/"$(hostname)"
fi
exit 0
