#!/bin/bash

##
# Directories
##

# Current directory
CUR="$(pwd)"

# Script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)"

##
# Backup
##

# Copy and date-stamp a given file
function backup() {
	cp $1 $1.backup-$(date +%y%m%d-%H%M%S-%N)
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

	# Test current $src and $dst values
	echo $src - $dst

	# Backup existing dotfile at $dst in place with timestamp
	backup $dst

	# Create symlink
	ln -sf $src $dst
done

##
# Scripts
##

# List all .sh scripts
files=$(find $DIR -type f -name "*.sh" | egrep -v "$DIR/.git|$DIR/tools/")

# Loop through all installation scripts in this repository
for file in $files
do
	# Test current $script value
	echo $file

	# Run current $script
	#sh $file
done

# Create symlinks for all folders and files found in the link directory
for folder in $(ls -A $DIR/links)
do
	rm $HOME/$folder
	ln -sf $DIR/links/$folder $HOME/$folder
done

# Link common shell functions
ln -sf $DIR/shell $HOME/.shell
