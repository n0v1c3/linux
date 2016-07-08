#!/bin/bash
#
# a simple dmenu session script 
#
###

DMENU='dmenu -i -nb #14151f -nf #999999 -sb #000000 -sf #31658C'

choice=$(echo "arandr
clementine
deluge
firefox
geany
gedit
gource
hibernate
libreoffice
logout
reboot
remmina
retext
shutdown
software-center
suspend
teamviewer
terminator
thunar
virtualbox
vlc" | $DMENU)

	case "$choice" in
		arandr)
			arandr &
			;;
		clementine)
			clementine &
			;;
		deluge)
			deluge &
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
		retext)
			retext &
			;;
		remmina)
			remmina &
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
		virtualbox)
			virtualbox &
			;;
		vlc)
			vlc &
			;;
	esac
