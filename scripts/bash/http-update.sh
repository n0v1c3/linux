#!/bin/bash

case $(uname -a | tr '[:upper:]' '[:lower:]') in
	# Arch OS
	*arch*)
		mount="/srv/http"
		options=('/home/travis/Documents/development/phpmyplc/http' '/home/travis/Documents/development/rneDatabase/html' 'Quit')
		;;
	# Ubuntu OS
	*ubuntu*)
		mount="/var/www/html"
		options=('/home/rneadmin/Documents/projects/personal/phpmyplc/http' '/home/rneadmin/Documents/projects/rne/rneDatabase/html' 'Quit')
		;;
	# Invalid OS
	*)
		echo "Invalid OS"
		exit 1
		;;
esac

select opt in "${options[@]}"
do
	case $opt in
		"${options[0]}")
			selection=${options[0]}
			break
			;;
		"${options[1]}")
			selection=${options[1]}
			break
			;;
		"Quit")
			exit 0
			break
			;;
		*)
			echo "Invalid selection!"
			exit 1
			break
			;;
	esac
done

sudo rm "$mount"
sudo ln -s "$selection" "$mount"
