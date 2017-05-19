#!/bin/bash

# Name: backup.sh
# Description: 

# Local backup (no delete)
rsync --archive /home /backups/localhost

# Network backup (with delete)
rsync --archive --delete -e ssh /home /mnt/tjg/office/backups/$(hostname)

# ====
# Exit
# ====

# Successful execution
exit 0
