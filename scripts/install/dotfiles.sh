#!/bin/bash

# Name: linux - install-dotfiles
# Desc: Install or update current user's configuration
# Paramaters:
# - Flags
#    - -b --backup (output_dir)  Backup any files that would be affected
#    - -h, --help		show brief help
#    - -b, --backup		backup all dotfiles
#    - -c, --clean-up	remove old backup files
#    - -d, --diff		display the diff for all dotfiles that would be changed
#    - -l, --links		link all dotfiles and dot directories
#    - -s, --scripts	run all scripts in repository
# ---
# Constants
# ---

# Script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)"

# Set newline as only list separator
IFS=$'\n'

# ===
# Setup
# ===
# Define common variables and functions used throughout

# ---
# Functions
# ---

# echo the required destination path
# Parameters:
# - $1: file
# - $2: user
function getDst()
{
    # Get the file destination
    dst=${1#*$DIR/config}

    # Adjust $dst path for current user's home directory
    if ( [[ $dst == /home/* ]] )
    then
        # Confirm a user was passed
        if ( [[ $2 ]] )
        then
            # Use the passed user's home directory
            home=/home/$2
        else
            # Use the current user's home directory
            home=$HOME
        fi

        # Add current user's home path and strip ./home/* from $dst
        dst=$home/${dst#*/*/}
    fi

    # Echo the results
    echo $dst
}

# Create a configuration directory
mkdir $HOME/.config

# ===
# Main
# ===

# Dotfiles
files=$(find $DIR -type f -name "*" | egrep "$DIR/config/")

# Dot directories
links=$(find -L $DIR -xtype l -name "*" | egrep "$DIR/config/")

# Loop through options
while test $# -gt 0
do
    case "$1" in
        -h|--help)
            # Display help file
            echo "Script: $DIR/scripts/dot-install.sh"
            echo "-h, --help		show brief help"
            echo "-b, --backup		backup all dotfiles"
            echo "-c, --clean-up	remove old backup files"
            echo "-d, --diff		display the diff for all dotfiles that would be changed with the -l --links flag"
            echo "-l, --links		link all dotfiles and dot directories"
            echo "-s, --scripts		run all scripts in repository"
            ;;
        -b|--backup)
            # Backup existing dotfiles in place with timestamp
            for file in $files
            do
                # Destination path
                dst=$(getDst $file $user)

                # Copy each dotfile that could be overwritten
                cp $dst $dst.backup-$(date +%y%m%d-%H%M%S-%N)
            done
            ;;
        -c|--clean-up)
            # Remove old backup files
            find . -type f -iname '*.backup-*' | xargs rm
            ;;
        -d|--diff)
            # Loop through each file
            for file in $files
            do
                # Display the current $src and $dst diff
                diff "$file" "$(getDst $file $user)"
            done
            ;;
        -l|--link)
            # Loop through each file
            for file in $files
            do
                # Create a link for each file
                ln -sf "$file" "$(getDst $file $user)"
            done

            # Loop through each link
            for link in $links
            do
                # Destination path
                dst=$(getDst "$link" $user)

                # Source path
                src=$(stat -c %N "$link")
                #src=${src#*->\ ‘}
                src=${src#*-> \'}
                #src=$DIR/${src%*’}
                src=${src%\'*}

                # Add dotfile dir if not on local system
                # local files will be prefixed with a '/'
                if ( [[ $src != /* ]] )
                then
                    src=$DIR/$src
                fi

                # Remove old files
                rm -rf $dst

                # Create symlink to directory
                ln -s $src $dst
            done

            # Git push (without passing a refspec) will fail if the current branch is not tracking an upstream branch (even if a branch of the same name exists upstream)
            git config --global push.default simple
            ;;
        -s|--scripts)
            # List all .sh scripts
            files=$(find $DIR/scripts/ -type f -name "*install.sh")

            # Loop through each file
            for file in $files
            do
                # Prevent redundancy of this file
                if [[ $file != *dot-install.sh ]]
                then
                    # Run the installation script
                    sh "$file"
                fi
            done
            ;;
        -u|--user)
            # Shift and store passed username
            shift
            user=$1

            # Create config directory for user
            mkdir /home/$user/.config
            ;;
        -v|--vim)
            bash $DIR/scripts/vim-bundle.sh
            ;;
        -z|--zsh)
            # Install Oh-My-Zsh
            sh "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
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
