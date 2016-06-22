#!/bin/bash

key_binding_file="/usr/share/X11/xkd/symbols/ca"

# Backup current key bindings and copy custom bindings from repository
#mv "$key_binding_file" "$keybinding-backup-$(date %y%m%d-%H%M%S-%N)"
#cp $LINUX_DIR/home/.vim/ca "$key_binding_file"

# Backup current vimrc and copy custom vimrc from repository
mv ~/.vimrc ~/.vimrc-backup-$(date +%y%m%d-%H%M%S-%N))
cp $LINUX_DIR/home/.vimrc ~/.vimrc

# Backup current .vim and copy custom .vim from repository
mv ~/.vim ~/.vim-backup-$(date +%y%m%d-%H%M%S-%N))
cp -ar $LINUX_DIR/home/.vim ~/.vim
