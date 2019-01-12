#!/bin/sh

choice=$(echo "lock
logout
exit
reboot
shutdown" | dmenu -i -b -p '   ' -fn 'DejaVu Sans Mono:regular:pixelsize=18' -nf '#4794ac' -nb '#0d0e11' -sb '#367c84' -sf '#0d0e11'
)

case "$choice" in
'lock') echo "lock" & ;;
'logout') echo "logout" & ;;
'exit') i3-msg exit & ;;
'reboot') shutdown -r 0 & ;;
'shutdown') shutdown -h 0 & ;;
'*') exit 1 ;;
esac

exit 0
