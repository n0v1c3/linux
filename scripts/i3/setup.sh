#!/bin/bash

# Backup existing i3 config
mv ~/.i3/config ~/.i3/config-backup-$(date +%y%m%d-%H%M%S-%N)

# Copy repo i3 config into  user's home directory
cp $LINUX_DIR/home/.i3/config ~/.i3/config
