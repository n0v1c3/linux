#            _              
#           | |             
#    _______| |__  _ __ ___ 
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__ 
# (_)___|___/_| |_|_|  \___|

# Name: .zshrc
# Description: Configuration for zsh shell

# Set name of the theme to load, look in ~/.oh-my-zsh/themes/
#ZSH_THEME="random"
ZSH_THEME="agnoster"
#ZSH_THEME="robbyrussell"

# Interchange - with _ and _ with -
HYPHEN_INSENSITIVE="true"

# Oh-My-Zsh auto updates disabled
DISABLE_AUTO_UPDATE="true"

# Command auto correction
#ENABLE_CORRECTION="true"

# History date stamp format
HIST_STAMPS="yyyy-mm-dd"

PROMPT_COMMAND=""

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vi-mode history-substring-search)

# Vi mode
bindkey -v

# Oh-My-Zsh
source $HOME/.oh-my-zsh/oh-my-zsh.sh

# Source common shell configurations
source $HOME/.shrc
