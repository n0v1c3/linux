#!/bin/bash
# TODO [161001] - I don't know what the purpose of this file is any more

# Script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"

##
# Backup
##

# TODO [161001] - Why is this here?
# Copy and date-stamp a given file
function backup() {
cp $1 $1.backup-$(date +%y%m%d-%H%M%S-%N)
}

##
# Symlinks
##

# List all dotfiles
files=$(find $DIR -type f -name "*" | egrep "/config/")

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
   diff $src $dst
done
