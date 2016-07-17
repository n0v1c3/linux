#!/bin/bash

# Script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)"

# Set newline as only list separator
IFS=$'\n'

mkdir $HOME/.config

# TODO - Not Used
function isLink()
{
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
		if ( [[ $2 ]] )
		then
			home=/home/$2
		else
			home=$HOME
		fi

		# Add current user's home path and strip ./home/* from $dst
		dst=$home/${dst#*/*/}
	fi

	echo $dst
}

# List all config dotfiles
files=$(find $DIR -type f -name "*" | egrep "$DIR/config/")

# List all dotdirs
links=$(find -L $DIR -xtype l -name "*" | egrep "$DIR/config/")

while test $# -gt 0
do
	case "$1" in
		-h|--help)
			echo "Script: $DIR/tools/install.sh"
			echo "-h, --help		show brief help"
			echo "-b, --backup		backup all dotfiles"
			echo "-c, --clean-up		backup all dotfiles"
			echo "-d, --diff		backup all dotfiles"
			echo "-l, --links		link all dotfiles and dotdirs"
			echo "-s, --scripts		run all scripts in repository"
			;;
		-b|--backup)
			# Backup existing dotfiles in place with timestamp
			for file in $files
			do
				dst=$(getDst "$file" $user)
				cp $dst $dst.backup-$(date +%y%m%d-%H%M%S-%N)
			done
			;;

		-c|--clean-up)
			# TODO - Add diff check only removing identical backups
			find . -type f -iname '*.backup-*' | xargs rm
			;;

		-d|--diff)
			for file in $files
			do
				# Test current $src and $dst values
				diff "$file" "$(getDst $file $user)"
			done
			;;

		-l|--link)
			# Install Oh-My-ZSH
			sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

			# Link all confg dotfiles
			for file in $files
			do
				dst=$(getDst "$file" $user)
				ln -sf "$file" "$dst"
			done

			for link in $links
			do
				# Destination path
				dst=$(getDst "$link" $user)

				# Source path
				src=$(stat -c %N "$link")
				#src=${src#*->\ ‘}
				src=${src#*-> \'}
				#src=$DIR/${src%*’}
				src=$DIR/${src%\'*}

				# Create symlink to directory
				rm $dst
				ln -s $src $dst
			done
			;;

		-s|--scripts)
			# List all .sh scripts
			files=$(find $DIR/scripts/ -type f -name "*install.sh")

			# Loop through all installation scripts in this repository
			for file in $files
			do
				if [[ $file != *dot-install.sh ]]
				then
					#echo $file
					sh "$file"
				fi
			done
			;;

		-u|--user)
			shift
			cp -r /root/.oh-my-zsh /home/$1/
			user=$1
			mkdir /home/$user/.config
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
