#!/bin/bash

#===================================================================================================
# a simple dmenu session script
#===================================================================================================
choice=$(
echo "  
 browser
 disk
 files
 gimp
 kodi
 LaTex
 office
 pass
⏻ power
🖧 rdp
🖵 screen
 snip
 terminal
 torrent
 virtualbox" | dmenu -i -b -p '   ' -fn 'DejaVu Sans Mono:regular:pixelsize=18' -nf '#4794ac' -nb '#0d0e11' -sb '#367c84' -sf '#0d0e11'
)

case "$choice" in
'  ') i3-sensible-terminal & ;;
' browser') firefox & ;;
' disk') baobab & ;;
' files') thunar & ;;
' gimp') gimp & ;;
' kodi') kodi & ;;
' LaTex') texmaker & ;;
' office') libreoffice & ;;
' pass') dmenu-pass & ;;
'⏻ power') dmenu-power & ;;
'🖧 rdp') remmina & ;;
'🖵 screen') arandr & ;;
' snip') mkdir -p ~/Downloads/scrot; cd ~/Downloads/scrot || exit; scrot -s & ;;
' terminal') i3-sensible-terminal & ;;
' torrent') deluge & ;;
' virtualbox') virtualbox & ;;
*) firefox "https://google.ca/search?q=$(echo $choice | tr ' ' '+')" ;;
esac
