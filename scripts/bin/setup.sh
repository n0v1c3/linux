#!/bin/bash

repo_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
length=`echo $repo_dir | grep -b -o "/linux/" | awk 'BEGIN {FS=":"}{print $1}'`
parent_dir=${repo_dir:0:$length}"/linux"

# Backkup user's existing .bin folder
cp -r ~/.bin ~/.bin-backup

# Delete current .bin folder
rm -r ~/.bin

# Create .bin folder if none exists
mkdir ~/.bin

# Add path to .bashrc file
bashrc_path="export PATH=\$PATH:~/.bin"
count=$(cat ~/.bashrc | grep "$bashrc_path" | wc -l)
if [ $count -eq 0 ]; then
	echo "$bashrc_path" >> ~/.bashrc
fi

# Create links to desired scrpits
ln -s $parent_dir"/scripts/bash/c.sh" ~/.bin/c
ln -s $parent_dir"/scripts/bash/ca.sh" ~/.bin/ca
ln -s $parent_dir"/scripts/bash/cl.sh" ~/.bin/cl
ln -s $parent_dir"/scripts/bash/cla.sh" ~/.bin/cla
ln -s $parent_dir"/scripts/tmux/my-tmux.sh" ~/.bin/my-tmux
ln -s $parent_dir"/scripts/git/notify.sh" ~/.bin/notify
