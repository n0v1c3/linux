#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

function git_status() {
stat="git"
if git diff-index --quiet HEAD --; then
    # No changes
    echo -n ""
else
    # Changes
    stat=$stat+"DIFF"
fi
echo "$stat"
}

prompt=$(git_status)
echo "$prompt"

# ---
# Exit
# ---
# Successful execution
exit 0
