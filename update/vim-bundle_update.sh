#!/bin/bash

# Name: vim-bundle_update.sh
# Description: git pull all vim bundles
# Authors: Travis Gall
# Notes:
# - Ref. in crontab of user travis

echo "===vim-bundle_update.sh===<br />"
path="/home/travis/.vim/bundle"
for file in $(ls "$path"); do
    cd "$path/$file" || exit
    echo "---$file---<br />"
    git pull
    echo "<br /><br />"
    cd .. || exit
done
