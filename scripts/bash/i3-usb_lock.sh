#!/bin/bash

# Name: i3-usb_lock.sh
# Description: 

[[ (-n "pidof i3lock") ]] && sudo -H -u travis bash -c "export DISPLAY=\":0\";  export XAUTHORITY=\"/home/travis/.config/xsession/.Xauthority\"; /usr/bin/i3lock -n"

# ---
# Exit
# ---
# Successful execution
exit 0

