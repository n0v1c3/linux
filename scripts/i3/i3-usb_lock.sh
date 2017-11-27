#!/bin/bash

# Name: i3-usb_lock.sh
# Description: Lock PC upon USB modification
# Author: Travis Gall

# TODO [171103] - Make work for any username
[[ (-n $(pidof i3lock)) ]] && \
# sudo -H -u travis bash -c "export DISPLAY=\":0\";  export XAUTHORITY=\"/home/travis/.config/xsession/.Xauthority\"; /usr/bin/i3lock -n"
sudo -H -u travis bash -c "export DISPLAY=\":0\";"
sudo -H -u travis bash -c "export XAUTHORITY=\"/home/travis/.config/xsession/.Xauthority\";"
sudo -H -u travis bash -c "export /usr/bin/i3lock -n"

# Successful execution
exit 0
