#!/bin/bash

##
# Backup
##

function backup() {
	cp $1 $1.backup-$(date +%y%m%d-%H%M%S-%N)
}

##
# Symlinks
##

# Loop through all dotfiles contained in this repository
for link in $(find . -type f -iname '*' -not -path '*install.sh' -not -path './func/*' -not -path './.git/*' -not -path './README.md')
do
	# File to be copied ($src) and destination ($dst)
	src=${link}
	dst=/${link#*./}

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

	# Remove existing dotfile
	rm $dst

	# Create symlink
	ln -s $src $dst
done

##
# Installs
##

# Loop through all installation scripts in this repository
for script in $(find . -iname '*install*.sh' -not -path './install.sh' -not -path './.git/*')
do
	# Test current $script value
	echo $script

	# Run current $script
	#sh $script
done

# Link .bin and .func folders to current user's home directory
#ln -s ./home/.bin ~/.bin
#ln -s ./home/.func ~/.func
