#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

# Get current branch name
# Syntax highlighting
# ===
# Functions
# ===
# Generate status prompt based on the git status of the current directory
git_status() {
stat="\033[0m"
# Check for changes in git repo
if ! git diff-index --quiet HEAD --; then
    # Update '$stat'
    grey="\033[0m"
    branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
    branch_name="(unnamed branch)"     # detached HEAD
    branch_name=${branch_name##refs/heads/}

    stat="\033[33m"
fi
# Send the final git prompt to STDOUT
echo "$grey($stat$branch_name$grey)"
}

# ===
# Main
# ===
# TODO [170130] - Confirm user is in a git repo
# TODO [170130] - Create a script to configure all desired colours



# ===
# Exit
# ===
# Successful execution
exit 0
