##
# .zshrc
# Configuratin for zsh shell
#
# TODO (160721) - Seach history for partially typed content on UP-ARROW key press
##

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
#ZSH_THEME="random"
#ZSH_THEME="agnoster"
ZSH_THEME="robbyrussell"

# Interchange - with _ and _ with -
HYPHEN_INSENSITIVE="true"

# Oh-My-Zsh auto updates disabled
DISABLE_AUTO_UPDATE="true"

# Command auto correction
#ENABLE_CORRECTION="true"

# History date stamp format
HIST_STAMPS="yyyy-mm-dd"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode)

# Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

##
# Shell
##

# Source common shell configurations
for file in $(find $HOME/.shell/ -type f -name "*") ; do source $file ; done

# Reload zsh dotfile
alias reload!='. ~/.zshrc'

# Vi mode
bindkey -v
