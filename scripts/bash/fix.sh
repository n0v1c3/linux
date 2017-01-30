#!/bin/bash

echo $1

rm $1
ln -s /home/travis/Documents/development/n0v1c3/linux/dotfiles/home/.config/$1 $1
