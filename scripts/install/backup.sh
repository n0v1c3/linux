#!/bin/bash

# Name: backup.sh
# Description: 

# Local backup (no delete)
rsync --archive --progress /home /backups/localhost

# Network backup (with delete)
rsync --archive --progress --delete -e ssh /home /mnt/tjg/office/backups/$(hostname)

# Backup tjg-office to usb-wd when connected
if [ "$(hostname)" = "tjg-office" -a "$(mount | grep /mnt/usb/wd > /dev/null)" ]; then
    rsync --archive --progress --delete --exclude={"/backups/localhost/*"} /backups /mnt/usb/wd
fi

# ====
# Exit
# ====

# Successful execution
exit 0
