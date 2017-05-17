#!/bin/bash

# Name: backup.sh
# Description: 

# Local backup (no delete)
rsync --archive /home /backups/localhost

# Local backup (with delete)
rsync --archive --delete /home /backups/$(hostname)

# Network backup (with delete)
rsync --archive --delete -e ssh /home /mnt/tjg/office/backups/$(hostname)

# ====
# Exit
# ====

# Successful execution
exit 0
