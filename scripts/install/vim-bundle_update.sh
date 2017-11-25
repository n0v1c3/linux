#!/bin/bash

# Name: vim-bundle_update.sh
# Description: git pull all vim bundles
# Authors: Travis Gall

# TODO-TJG [171124] - Prepare for crontab
path="$n0v1c3/linux/dotfiles/home/.vim/bundle"
for file in $(ls "$path"); do
    cd "$path/$file" || exit
    git pull
    cd .. || exit
done
