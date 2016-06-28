#!/bin/bash

##
# Directories
##

# Current directory
CUR="$(pwd)"

# Script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)"

##
# Functions
##

# Copy and date-stamp a given file
function backup() {
	cp $1 $1.backup-$(date +%y%m%d-%H%M%S-%N)
}

# TODO - Not Used
function isLink() {
	# Link common shell functions
	ln -sf $DIR/shell $HOME/.shell
	raw=$1
	stat=$(stat -c %N -- "$raw")

	if [ "‘$raw’" != "$stat" ]
	then
		return true
	fi

	return false
}

##
# Symlinks
##

# List all dotfiles
files=$(find $DIR -type f -name "*" | egrep "$DIR/config/")

# Loop through all dotfiles contained in this repository
for file in $files
do
	# File to be copied ($src) and destination ($dst)
	dst=${file#*$DIR/config}
	src=$file

	# Adjust $dst path for current user's home directory
	if ( [[ $dst == */home/* ]] )
	then
		# Add current user's home path and strip ./home/* from $dst
		dst=$HOME/${dst#*/*/}
	fi

	# Backup existing dotfile at $dst in place with timestamp
	backup $dst

	# Create symlink
	ln -sf $src $dst
done

links=$(find -L $DIR -xtype l -name "*" | egrep "/config/")
for link in $links
do
	# Destination path
	dst=${link#*$DIR/config}

	# Adjust $dst path for current user's home directory
	if ( [[ $dst == */home/* ]] )
	then
		# Add current user's home path and strip ./home/* from $dst
		dst=$HOME/${dst#/home/*}
	fi

	# Source path
	src=$(stat -c %N $link)
	src=${src#*->\ ‘}
	src=$DIR/${src%*’}
	
	# Create symlink to directory
	rm $dst
	ln -s $link $dst
done

##
# Scripts
##

# List all .sh scripts
files=$(find $DIR -type f -name "*.sh" | egrep -v "$DIR/.git|$DIR/tools/")

# Loop through all installation scripts in this repository
for file in $files
do
	# Run current $script
	#sh $file
done
