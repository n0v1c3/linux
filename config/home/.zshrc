##
# .zshrc
# Configuratin for zsh shell
#
# TODO (160721) - Seach history for partially typed content on UP-ARROW key press
##

# Source common shell configurations
for file in $(find $HOME/.shell/ -type f -name "*") ; do source $file ; done

# Set name of the theme to load, look in ~/.oh-my-zsh/themes/
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
plugins=(git vi-mode)

# Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Source common shell configurations
for file in $(find $HOME/.shell/ -type f -name "*") ; do source $file ; done

# Vi mode
bindkey -v
