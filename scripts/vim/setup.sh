#!/bin/bash

key_binding_file="/usr/share/X11/xkd/symbols/ca"

# Buck-up existing key binding to be overwritten
mv "$key_binding_file" "$keybinding-backup"

# Copy custom key binding into the desired language
cp ~/Documents/linux/config/vim/ca "$key_binding_file"
