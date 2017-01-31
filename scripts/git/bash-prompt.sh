#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

# Generate status prompt based on the git status of the current directory
function git_status() {
stat="git"
if git diff-index --quiet HEAD --; then
    # No changes
    echo -n ""
else
    # Changes
    stat=$stat+"DIFF"
fi
echo -n "$stat"
}

echo $(git_status)

# ---
# Exit
# ---
# Successful execution
exit 0
