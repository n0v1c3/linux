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
GREY="\[\033[0m\]"
YELLOW="\[\033[33m\]"
git_status() {
stat="$GREY"
# Check for changes in git repo
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    # Update '$stat'
    grey="$GREY"
    branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
    branch_name="unnamed branch"     # detached HEAD
    branch_name=${branch_name##refs/heads/}

    stat="$YELLOW"
fi
echo "$grey($stat$branch_name$grey)"
}
grey="\[\033[00m\]" 
white="\[\033[97m\]" 
blue="\[\033[0;96m\]" 
green="\[\033[0;92m\]"
# Default prompts
prompt_config() {
    PS1="\n$grey$blue\u$white@$green\h$white:\w$grey\n$(git_status)\$ "
}
PS2="$white>$grey "

PROMPT_COMMAND='prompt_config'

# Clean-up
unset grey white blue green
