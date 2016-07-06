#!/bin/bash
#
# a simple dmenu session script 
#
###

DMENU='dmenu -i -b -nb #000000 -nf #999999 -sb #000000 -sf #31658C'

choice=$(echo "
arandr
firefox
geany
gedit
gource
hibernate
libreoffice
logout
reboot
shutdown
software-center
suspend
teamviewer
terminator
thunar" | $DMENU)

	case "$choice" in
		arandr)
			arandr &
			;;
		firefox)
			firefox &
			;;
		geany)
			geany &
			;;
		gedit)
			gedit &
			;;
		gource)
			gource $HOME/Documents/development/dotfiles &
			;;
		hibernate)
			sudo pm-hibernate &
			;;
		libreoffice)
			libreoffice &
			;;
		logout)
			i3-msg exit &
			;;
		reboot)
			sudo shutdown -r now &
			;;
		shutdown)
			sudo shutdown -h now &
			;;
		software-center)
			software-center &
			;;
		suspend)
			sudo pm-suspend &
			;;
		teamviewer)
			teamviewer &
			;;
		terminator)
			terminator &
			;;
		thunar)
			thunar &
			;;
	esac
