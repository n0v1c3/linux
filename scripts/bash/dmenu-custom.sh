#!/bin/bash

#===================================================================================================
# a simple dmenu session script 
#===================================================================================================
DMENU='dmenu -i -nb #14151f -nf #999999 -sb #000000 -sf #31658C'

choice=$(
echo " 
arandr
baobab
deluge
firefox
kodi
libreoffice
logout
reboot
remmina
retext
scrot
shutdown
synergy
terminator
thunar
virtualbox" | $DMENU
)

case "$choice" in
    ' ') i3-sensible-terminal & ;;
    'arandr') arandr & ;;
    'baobab') baobab & ;;
    'deluge') deluge & ;;
    'firefox') firefox & ;;
    'kodi') kodi & ;;
    'libreoffice') libreoffice & ;;
    'logout') i3-msg exit & ;;
    'reboot') shutdown -r now & ;;
    'retext') retext & ;;
    'remmina') remmina & ;;
    'scrot') mkdir -p ~/Downloads/scrot; cd ~/Downloads/scrot; scrot -s & ;;
    'shutdown') shutdown -h now & ;;
    'synergy') synergy & ;;
    'terminator') terminator & ;;
    'thunar') thunar & ;;
    'virtualbox') virtualbox & ;;
esac
