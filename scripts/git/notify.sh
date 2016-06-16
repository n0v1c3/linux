#!/bin/bash

gitdir="$(pwd)/.git"

# Titles
title="$(basename `git --git-dir=$gitdir rev-parse --show-toplevel`)"
titleWidth=$((${#title} + 2))
title1="BRANCH"
title2="STATUS"
title3="LOG"

# Font colours
NC='\033[0m'		# No colour
PURPLE='\033[1;35m'
WHITE='\033[1;37m'

while true; do
	clear

	# Branch title
	printf "${PURPLE}"
	printf "╔"
	printf "%0.s═" $(seq 1 $titleWidth)
	printf "╗"
	echo ""
	printf "║ $title ║\n"
	printf "╚"
	printf "%0.s═" $(seq 1 $titleWidth)
	printf "╝"
	echo ""
	printf "${NC}"
	
	# Branch list
	echo ""
	printf "${WHITE}$title1${NC}\n"
	git --git-dir=$gitdir branch

	# Current status
	echo ""
	printf "${WHITE}$title2${NC}\n"
	git --git-dir=$gitdir status -sb

	# Log
	echo ""
	printf "${WHITE}$title3${NC}\n"
	git --no-pager --git-dir=$gitdir log --pretty=format:'%s' -n 10 | cut -c1-44

	sleep 3

	if read -t0; then
		read a

		if [[ "$a" == "q" ]]; then
			clear
			break
		fi
		git checkout $a
	fi
done
