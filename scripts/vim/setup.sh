#!/bin/bash

key_binding_file="/usr/share/X11/xkd/symbols/ca"

#Back-up existing key binding to be overwritten
#cp "$key_binding_file" "$keybinding-backup"

# Copy custom key binding into the desired language
#cp ~/Documents/linux/config/vim/ca "$key_binding_file"

# Backup current vimrc
cp ~/.vimrc ~/.vimrc-backup

# Replace current vimrc with custom vimrc from repository
cp ~/Documents/linux/config/vim/vimrc ~/.vimrc
