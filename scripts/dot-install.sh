#!/bin/bash

################################################################################
# dot-install.sh
# Installation and configuration of all dot-files being used
################################################################################

# Script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )/.." && pwd)"

# Set newline as only list separator
IFS=$'\n'

mkdir $HOME/.config

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
            echo "-c, --clean-up	backup all dotfiles"
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
                src=${src%\'*}

                # Add dotfile dir if not on local system
                # local files will be prefixed with a '/'
                if ( [[ $src != /* ]] )
                then
                    src=$DIR/$src
                fi

                # Create symlink to directory
                rm -rf $dst
                ln -s $src $dst
            done

            git config --global push.default simple
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
