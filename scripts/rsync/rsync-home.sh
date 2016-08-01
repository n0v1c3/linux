#!/bin/bash

while test $# -gt 0
do
   case "$1" in
	  -l|--local)
		 opt="-avh --progress"
		 src=$HOME
		 dst=/mnt/nas
		 break
		 ;;
	  -s|--server)
		 opt="-avh --delete --progress"
		 src=/mnt/tjg-wd
		 dst=/mnt/nas
		 break
		 ;;
	  *)
		 break
		 ;;
   esac
done

rsync $opt $src $dst
