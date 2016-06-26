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

# Add an "alert" alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Predefined clear shortcuts (custom)
alias c="clear; pwd; ls --color=auto;"
alias ca="clear; pwd; ls -a --color=auto;"
alias cl="clear; pwd; ls -l --color=auto;"
alias cla="clear; pwd; ls -al --color=auto;"

# dirs, pushd and popd shortcuts
alias dirs="dirs -v"
alias d="dirs"
alias p="pushd . > /dev/null"
alias P="popd > /dev/null ; pwd"
alias pP="pushd . > /dev/null ; cd ~2 ; popd -n +2 > /dev/null ; pwd"
alias Pp="popd > /dev/null ; pushd . > /dev/null ; pwd"

# Predefined ls shortcuts (Ubuntu)
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# Ranger file browser
alias ranger="ranger -d ."

alias xterm="xterm -fa monospace -fs 10"
