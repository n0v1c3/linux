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

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]
then
   debian_chroot=$(cat /etc/debian_chroot)
fi

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

# Console prompts
PS1="\[\033[97m\][\[\033[0;96m\]\u\[\033[97m\]@\[\033[0;92m\]\h\[\033[97m\] \W]\[\033[00m\]$ "
PS2="\[\033[97m\]> \[\033[00m\]"

# Source common shell configurations
source ~/.shrc
