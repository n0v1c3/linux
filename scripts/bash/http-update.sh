#!/bin/bash

options=('/home/travis/Documents/development/phpmyplc/http' '/home/travis/Documents/development/rneDatabase/html' 'Quit')
#echo "${options[@]}"
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
			break
			;;
		*)
			echo "Invalid selection!"
	esac
done

sudo rm /srv/http
sudo ln -s "$selection" "/srv/http"
