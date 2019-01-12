#!/bin/bash

#===================================================================================================
# a simple dmenu session script
#===================================================================================================
choice=$(
echo "  
 arandr
 baobab
 browser
 deluge
 gimp
 kodi
 libreoffice
⏻ power
🖧 remmina
 screen-shot
 terminator
 texmaker
 thunar
 virtualbox" | dmenu -i -b -p '   ' -fn 'DejaVu Sans Mono:regular:pixelsize=18' -nf '#4794ac' -nb '#0d0e11' -sb '#367c84' -sf '#0d0e11'
)

case "$choice" in
'  ') i3-sensible-terminal & ;;
'🖵 arandr') arandr & ;;
'🖴 baobab') baobab & ;;
' browser') firefox & ;;
' deluge') deluge & ;;
' gimp') gimp & ;;
' kodi') kodi & ;;
' libreoffice') libreoffice & ;;
'⏻ power') dmenu-poer & ;;
'🖧 remmina') remmina & ;;
' snip') mkdir -p ~/Downloads/scrot; cd ~/Downloads/scrot || exit; scrot -s & ;;
' terminator') terminator & ;;
' texmaker') texmaker & ;;
' thunar') thunar & ;;
' virtualbox') virtualbox & ;;
esac
