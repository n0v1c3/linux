#!/bin/bash
#. /home/travis/Documents/development/n0v1c3/linux/scripts/git/bash-prompt.sh

################################################################################
# .bashrc
# Configuration file for the bash shell
#
################################################################################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
   *i*) ;;
*) return;;
esac

# ---
# History
# ---
# Ignore duplicate lines or lines starting with a space
HISTCONTROL=ignoreboth
# Append to the history file
shopt -s histappend

# ---
# Display
# ---
# Update values of LINES and COLUMNS after each command
shopt -s checkwinsize
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
   xterm-color)
	  color_prompt=yes
	  ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
   if [ -f /usr/share/bash-completion/bash_completion ]; then
	  . /usr/share/bash-completion/bash_completion
   elif [ -f /etc/bash_completion ]; then
	  . /etc/bash_completion
   fi
fi

# Source common shell configurations
#source ~/.bin/git-prompt
source ~/.shrc

# Formatting
GREY="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m" 
LIGHT_RED="\e[91m"
LIGHT_GREEN="\e[92m"
LIGHT_YELLOW="\e[93m"
LIGHT_BLUE="\e[94m" 
WHITE="\e[37m" 

git_status() {
    # Default stat
    stat="$GREEN"

    branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
    branch_name="unnamed branch"     # detached HEAD
    branch_name=${branch_name##refs/heads/}
    # Check for changes in git repo
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        # Update '$stat'
        stat="$RED"
    fi
    echo "$GREY($stat$branch_name$GREY)"
}

# Default prompts
prompt_command() {
    PS1="\n$BLUE\u$WHITE@$GREEN\h$WHITE: \w\n"
    if git rev-parse --git-dir> /dev/null 2>/dev/null; then
        PS1+="$(git_status)"
    fi
    PS1+="\$ "
}
PS2="$white>$GREY "
# Trigger prompt to update all functions
PROMPT_COMMAND='prompt_command'

# Set default edinting mode to vi
bind 'set editing-mode vi'

# Tab auto complete
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

export WAN=1
