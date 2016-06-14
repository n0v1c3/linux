#!/bin/bash

# Backup current ranger configuration
mv ~/.config/ranger/rc.conf ~/.config/ranger/rc.conf-backup-$(date +%y+m+d-%H%M%S-%N)

# Copy ranger configuration from repo to user's home directory
cp $LINUX_DIR/home/.config/ranger/rc.conf ~/.config/ranger/rc.conf
