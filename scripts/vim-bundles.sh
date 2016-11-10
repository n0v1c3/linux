#!/bin/bash

# Name: vim-bundles.sh
# Description: Clone and update desired bundles

# TODO [161017] - This should be included with a dotfiles installer

# Notes:
# - Run dot-install.sh -s to automatically run this script

function gitHubBundle {
# Directory path for plugin relative to ~/.vim/bundle
dir=${1#*/}

# Confirm bundle directory
if [ ! -d $HOME/.vim/bundle/$dir ]
then
    # Directory does not exist, clone repository from github
    git clone "https://github.com/$1.git" ~/.vim/bundle/$dir
else
    # Directory exists, update from github.com
    cd ~/.vim/bundle/$dir
    git pull
fi
}

# Create required directories
mkdir -p ~/.vim/autoload ~/.vim/bundle && \

# Copy latest copy of pathogen from tpo.pe
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# List of desired bundles
declare -a gitHubList=(
"scrooloose/nerdcommenter"
"scrooloose/nerdtree"
"ryanoasis/vim-devicons"
"dhruvasagar/vim-table-mode"
)

# Loop through each bundle
for i in ${gitHubList[@]}
do
    # Download and install current bundle
    gitHubBundle "$i"
done
