#!/bin/bash

##
# Symlinks
##

for link in $(find . -type f -iname '*' -not -path '*install.sh' -not -path './.git/*' -not -path './README.md')
do
	src=${link}
	dst=/${link#*./*/}
	
	if ( [[ $dst == /home/* ]] )
	then
		dst=$HOME/${dst#*/*/}
	fi

	echo $src - $dst
	#ln -s $src $dst
done

##
# Installs
##

for script in $(find . -iname '*install*.sh' -not -path './install.sh' -not -path './.git/*')
do
	echo $script
	#sh $script
done
