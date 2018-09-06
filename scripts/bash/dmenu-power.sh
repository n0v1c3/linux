#!/bin/sh

choice=$(echo "lock
logout
exit
reboot
shutdown" | dmenu -b -p " Power ")

case "$choice" in
'lock') echo "lock" & ;;
'logout') echo "logout" & ;;
'exit') i3-msg exit & ;;
'reboot') shutdown -r 0 & ;;
'shutdown') shutdown -h 0 & ;;
'*') exit 1 ;;
esac

exit 0
