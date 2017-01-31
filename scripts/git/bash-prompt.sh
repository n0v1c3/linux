#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

# ===
# Functions
# ===
# Generate status prompt based on the git status of the current directory
function git_status() {

stat="\033[0m"
# Check for changes in git repo
if ! git diff-index --quiet HEAD --; then
    # Update '$stat'
    stat="\033[33m"
fi
echo -n "$stat"
}

# ===
# Main
# ===
# TODO [170130] - Confirm user is in a git repo
# TODO [170130] - Create a script to configure all desired colours
# Syntax highlighting
grey="\033[0m"

# Get current branch name
branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
branch_name="(unnamed branch)"     # detached HEAD
branch_name=${branch_name##refs/heads/}

# Send the final git prompt to STDOUT
echo "$grey($(git_status)$branch_name$grey)"

# ===
# Exit
# ===
# Successful execution
exit 0
