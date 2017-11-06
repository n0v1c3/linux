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
texmaker
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
    'remmina') remmina & ;;
    'retext') retext & ;;
    'scrot') mkdir -p ~/downloads/scrot; cd ~/downloads/scrot || exit; scrot -s & ;;
    'shutdown') shutdown -h now & ;;
    'synergy') synergy & ;;
    'terminator') terminator & ;;
    'texmaker') texmaker & ;;
    'thunar') thunar & ;;
    'virtualbox') virtualbox & ;;
esac
