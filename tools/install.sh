#!/bin/bash

# Script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)"

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

function getDst() 
{
	dst=${1#*$DIR/config}

	# Adjust $dst path for current user's home directory
	if ( [[ $dst == /home/* ]] )
	then
		# Add current user's home path and strip ./home/* from $dst
		dst=$HOME/${dst#*/*/}
	fi
	
	echo $dst
}

# List all config dotfiles
files=$(find $DIR -type f -name "*" | egrep "$DIR/config/")

# List all dir dotfiles
links=$(find -L $DIR -xtype l -name "*" | egrep "/config/")

while test $# -gt 0
do
	case "$1" in
		-h|--help)
			echo "Script: $DIR/tools/install.sh"
			echo "-h, --help	show brief help"
			echo "-b, --backup	backup all dotfiles"
			echo "-l, --links	link all dotfiles and dotfolders"
			echo "-s, --scripts	run all scripts in repository"
			;;
		-b|--backup)
			# Backup existing dotfiles in place with timestamp
			for file in $files
			do
				dst=$(getDst $file)
				cp $dst $dst.backup-$(date +%y%m%d-%H%M%S-%N)
			done
			;;

		-l|--link)
			# Link all confg dotfiles
			for file in $files
			do
				dst=$(getDst $file)
				ln -sf $file $dst
			done

			# Link all directory dotfolders
			for link in $links
			do
				# Destination path
				dst=$(getDst $link)

				# Source path
				src=$(stat -c %N $link)
				src=${src#*->\ ‘}
				src=$DIR/${src%*’}

				# Create symlink to directory
				rm $dst
				ln -s $link $dst
			done
			;;

		-s|--scripts)
			# List all .sh scripts
			files=$(find $DIR -type f -name "*.sh" | egrep -v "$DIR/.git|$DIR/tools/")

			# Loop through all installation scripts in this repository
			for file in $files ; do sh $file ; done
			;;

		*)
			break
			;;
	esac

	# Shift $#
	shift
done

# Finished no errors
exit 0
