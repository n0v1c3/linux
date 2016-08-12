#!/bin/bash

opt="-avh --progress"
dst="/mnt/nas"

while test $# -gt 0
do
   case "$1" in
	  -f|--file)
		 shift
		 file=$1

		 opt="$opt"
		 src="$file"
		 dst="$dst"
		 break
		 ;;
	  -l|--local)
		 opt="$opt"
		 src="$HOME"
		 dst="$dst"
		 break
		 ;;
	  -s|--server)
		 opt="$opt --delete"
		 src=/mnt/tjg-wd
		 dst="$dst"
		 break
		 ;;
	  *)
		 break
		 ;;
   esac
done

rsync $opt --dry-run $src $dst
