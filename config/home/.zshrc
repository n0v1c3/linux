##
# .zshrc
# Configuration for zsh shell
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
plugins=(git vi-mode history-substring-search)

# Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Source common shell configurations
for file in $(find $HOME/.shell/ -type f -name "*") ; do source $file ; done

# Vi mode
bindkey -v

# Add  ruby executables to the PATH variable
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
