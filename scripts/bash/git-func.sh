#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

# Get current branch name
# Syntax highlighting

# Generate status prompt based on the git status of the current directory
git_prompt() {
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

# git status on current directory or one layer deep in non-repo
gs() {
    # Confirm if current directory is a valid git repository
    if [ $(git rev-parse -git-dir 2> /dev/null) ]; then
        git status -s

    else # current directory is not a git repo
        for D in `find ./ -mindepth 1 -maxdepth 1 -type d`
        do
            cd $D
            echo "\e[34m==="
            echo -e "$(pwd)"
            echo "==="
            git status -s
            echo "\e[34m---"
            cd ..
        done
    fi
}
