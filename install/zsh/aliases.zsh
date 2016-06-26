# Navigation
alias ..='cd ..'

# Clear screen
alias c='clear ; pwd ; ls'
alias ca='clear ; pwd ; la -a'
alias cl='clear ; pwd ; ls -l'
alias cla='clear ; pwd ; ls -la'

# dirs, pushd, and popd
alias dirs='dirs -v'
alias d='dirs'
alias p='pushd . > /dev/null'
alias P='popd > /dev/null'
alias pP='p ; cd ~2 ; popd -n +2 > /dev/null'
alias Pp='P ; p'

# Ubuntu ls shortcuts
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# Alert
alias alert="notify-send"
