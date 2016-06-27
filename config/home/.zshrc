# Import common configurations
source ~/.zsh/aliases.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/variables.zsh

# Path to your oh-my-zsh installation.
export ZSH=/home/travis/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Interchange - with _ and _ with -
HYPHEN_INSENSITIVE="true"

# Oh-My-Zsh auto updates disabled
DISABLE_AUTO_UPDATE="true"

# Command auto correction
ENABLE_CORRECTION="true"

# History date stamp format
HIST_STAMPS="yyyy-mm-dd"

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Reload zsh dotfile
alias reload!='. ~/.zshrc'
