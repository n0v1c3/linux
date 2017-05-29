#!/bin/bash

# Name: iso-bot.sh
# Description: 

# Get desired filename
echo -n "Please enter output filename: "
read filename

# Calculate the size of the iso in MB
blocks=$(isosize -d 2048 /dev/sr0)
echo -e "\nThere is $(expr $blocks / 512)MB of data to be ripped"

# Create iso file
dd if=/dev/sr0 of=$HOME/Downloads/$filename.iso bs=2048 count=$blocks status=progress

# Eject CD rom from drive bay
eject -r

# ---
# Exit
# ---
# Successful execution
exit 0

