#!/bin/bash

#===================================================================================================
# a simple dmenu session script
#===================================================================================================
choice=$(
echo "  
 arandr
 baobab
 deluge
 firefox
 gimp
 kodi
 libreoffice
 logout
⏻ reboot
🖧 remmina
 screen-shot
⏻ shutdown
 terminator
 texmaker
 thunar
 virtualbox" | dmenu -i -b -p '   ' -fn 'DejaVu Sans Mono:regular:pixelsize=18' -nf '#4794ac' -nb '#0d0e11' -sb '#367c84' -sf '#0d0e11'
)

case "$choice" in
'  ') i3-sensible-terminal & ;;
'🖵 arandr') arandr & ;;
'🖴 baobab') baobab & ;;
' deluge') deluge & ;;
' firefox') firefox & ;;
' gimp') gimp & ;;
' kodi') kodi & ;;
' libreoffice') libreoffice & ;;
' logout') i3-msg exit & ;;
'⏻ reboot') shutdown -r now & ;;
'🖧 remmina') remmina & ;;
' screen-shot') mkdir -p ~/Downloads/scrot; cd ~/Downloads/scrot || exit; scrot -s & ;;
'⏻ shutdown') shutdown -h now & ;;
' terminator') i3-sensible-terminal & ;;
' texmaker') texmaker & ;;
' thunar') thunar & ;;
' virtualbox') virtualbox & ;;
esac
