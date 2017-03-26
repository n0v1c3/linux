#!/bin/bash

# Name: ahk.sh
# Description: 

# Push current directory prior to direcotry change
function pushd_cd() {
pushd $@ > /dev/null
}

# Pop last directory
function pushd_cd() {
popd
}

# Run custom workspace script on directory change
function workspace_cd() {
cd $@ && [ -f ".workspace" ] && source .workspace
}

alias cdp="pushd_cd"
alias cdb="popd_cd"
alias cd="workspace_cd"
