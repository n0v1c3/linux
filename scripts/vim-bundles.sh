#!/bin/bash

# Name: vim-bundles.sh
# Description: Clone and update desired bundles

function gitHubBundle {
    # Clone repository from github
    echo "https://github.com/$1.git"
    git clone "https://github.com/$1.git"

    # Update existing repository
    dir=${1#*/}
    echo $dir
    cd $dir
    git pull
    cd ..
}

cd ~/.vim/
mkdir ./bundle
cd ./bundle

gitHubBundle "scrooloose/nerdcommenter"
gitHubBundle "scrooloose/nerdtree"
gitHubBundle "ryanoasis/vim-devicons"
gitHubBundle "dhruvasagar/vim-table-mode"
