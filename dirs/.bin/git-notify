#!/bin/bash

gitdir="$(pwd)/.git"
title="$(basename `git --git-dir=$gitdir rev-parse --show-toplevel`)"

NC='\033[0m'
BOLD='\033[1;37m'

git-notify() {
while true; do
	current_branch=$(git --git-dir=$gitdir branch)		
	current_status=$(git --git-dir=$gitdir status -sb)
	current_log=$(git --git-dir=$gitdir log --pretty=format:'%s' -n 1)

	if [[ "$current_branch" != "$previous_branch" ]] || [[ "$current_status" != "$previous_status" ]] || [[ "$current_log" != "$previous_log" ]] ; then
		clear
		printf "${BOLD}$title${NC}\n"
		printf "\n${BOLD}BRANCH${NC}\n"
		git --git-dir=$gitdir branch
		printf "\n${BOLD}STATUS${NC}\n"
		git --git-dir=$gitdir status -sb
		printf "\n${BOLD}LOG${NC}\n"
		git --no-pager --git-dir=$gitdir log --pretty=format:'%s' -n 10 | cut -c1-44

		printf "\ngit checkout "
	fi

	previous_branch=$current_branch
	previous_status=$current_status
	previous_log=$current_log

	# Read user input
	if read -t0; then
		read a

		if [[ "$a" == "q" ]]; then
			clear
			break
		fi
		git --git-dir=$gitdir checkout $a
	fi

	sleep 1
done
}

if git pull; then
	sleep 1
	git-notify
fi
