#!/bin/bash

options=("$n0v1c3/phpmyplc/http" "$rne/cacGenerator/http" "$rne/rneDatabase/html" "Quit")
case $(uname -a | tr '[:upper:]' '[:lower:]') in
	# Arch OS
	*arch*)
		mount="/srv/http"
		;;
	# Ubuntu OS
	*ubuntu*)
		mount="/var/www/html"
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
		"Quit")
			exit 0
			break
			;;
		*)
            selection=$opt
			break
			;;
	esac
done

sudo rm "$mount"
sudo ln -s "$selection" "$mount"
