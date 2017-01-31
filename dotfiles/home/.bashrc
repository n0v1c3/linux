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
source ~/.shrc

# Formatting
grey="\[\033[00m\]" 
white="\[\033[97m\]" 
blue="\[\033[0;96m\]" 
green="\[\033[0;92m\]"
# Default prompts
PS1="\n$grey$blue\u$white@$green\h$white:\w$grey\n$(git-prompt)\$ "  
PS2="$white>$grey "

# Clean-up
unset grey white blue green
