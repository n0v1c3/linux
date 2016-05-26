#!/bin/bash

# Backkup user's existing .bin folder
cp -r ~/.bin ~/.bin-backup

# Create .bin folder if none exists
mkdir ~/.bin

# Add path to .bashrc file
bashrc_path="export PATH=\$PATH:~/.bin"
count=$(cat ~/.bashrc | grep "$bashrc_path" | wc -l)
echo $count
if [ $count -eq 0 ]; then
	echo "$bashrc_path" >> ~/.bashrc
fi

# Create links to desired scrpits
ln -s ~/Documents/linux/scripts/bash/c.sh ~/.bin/c
ln -s ~/Documents/linux/scripts/bash/ca.sh ~/.bin/ca
ln -s ~/Documents/linux/scripts/bash/cl.sh ~/.bin/cl
ln -s ~/Documents/linux/scripts/bash/cla.sh ~/.bin/cla
ln -s ~/Documents/linux/scritps/tmux/my-tmux.sh ~/.bin/my-tmux
