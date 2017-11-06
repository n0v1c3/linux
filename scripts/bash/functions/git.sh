#!/bin/bash

# Name: bash-prompt.sh
# Description: Prepared outputs that can be added to the bash prompt string

blue="\e[34m"
yellow="\e[33m"

# Get current branch name
# Syntax highlighting

# Generate status prompt based on the git status of the current directory
git-prompt() {
    if [ "$(git rev-parse -git-dir 2> /dev/null)" ]; then
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
git-status() {
    # Confirm if current directory is a valid git repository
    if [ "$(git rev-parse -git-dir 2> /dev/null)" ]; then
        git status -s

    else
        # Loop through each directory in the current directory
        for D in $(find . -mindepth 1 -maxdepth 1 -type d); do
            # Change directory and display git status
            pushd "$D" > /dev/null
            printf "\n%s==========%S" "$blue" "$yellow"
            pwd
            git status -s; echo ""
            echo "$blue----------"
            popd > /dev/null
        done
    fi
}

# Search for existing commits by email, update, and force push new committer information
function git-committer-change
{
    # 1 - Open terminal
    # 2 - Create a fresh, bare clone of your repository
    #   -- git clone --bare https://github.com/user/repo.git
    #   -- cd repo
    # 3 - Update OLD_EMAIL, CORRECT_NAME, and CORRECT_EMAIL with desired values
    # 4 - Run script

    git filter-branch --env-filter '
    OLD_EMAIL="travis.gall@gmail.com"
    CORRECT_NAME="Travis Gall"
    CORRECT_EMAIL="travis.gall@gmail.com"
    if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_COMMITTER_NAME="$CORRECT_NAME"
        export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
    fi
    if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
    then
        export GIT_AUTHOR_NAME="$CORRECT_NAME"
        export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    fi
    ' --tag-name-filter cat -- --branches --tags

    # 5 - Push the corrected history to GitHub
    git push --force --tags origin 'refs/heads/*'

    # 6 - Clean-up the temporary clone
    # cd ..
    # rm -rf repo
}

function git-script-dir
{
    cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd
}

function git-repo-dir
{
    script_dir=$(scriptDir)
    length=$(echo "$script_dir" | grep -b -o "/linux/" | awk 'BEGIN {FS=":"}{print $1}')
    repo_dir=${script_dir:0:$length}"/linux"
    echo "$repo_dir"
}

# Simple file meta data caching and applying
function git-meta
{
    cacheMetaFile=$(git rev-parse --show-toplevel)/.gitmeta

    case $@ in
        --store|--stdout)
            case $1 in
                --store)
                    exec > "$cacheMetaFile"
                    ;;
            esac

            find "$(git ls-files)"\
            \( -printf 'chown %U %p\n' \) \
            \( -printf 'chgrp %G %p\n' \) \
            \( -printf 'touch -c -d "%AY-%Am-%Ad %AH:%AM:%AS" %p\n' \) \
            \( -printf 'chmod %#m %p\n' \)
            ;;

        # Apply the current copy of $git
        --apply)
            sh -e "$cacheMetaFile"
            ;;
        *)
            1>&2 echo "Usage: $0 --store|--stdout|--apply"
            exit 1
            ;;
    esac
}
