#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

# Get current branch name
# Syntax highlighting

# Generate status prompt based on the git status of the current directory
git_status() {
    if [ $(git rev-parse -git-dir 2> /dev/null) ]; then
        stat="\033[0m"
        # Check for changes in git repo
        if ! git diff-index --quiet HEAD --; then
            grey="\033[0m"
            branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
            branch_name="(unnamed branch)"     # detached HEAD
            branch_name=${branch_name##refs/heads/}
            stat="\033[33m"
        fi

        # Send the final git prompt to STDOUT
        echo "$grey($stat$branch_name$grey)"
    fi
}

# ===
# Main
# ===
# TODO [170130] - Confirm user is in a git repo
# TODO [170130] - Create a script to configure all desired colours
git_status

# Successful execution
exit 0
