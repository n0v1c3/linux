#!/bin/bash

function scriptDir
{
	echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
}

function repoDir
{
	script_dir=$(scriptDir)
	length=`echo $script_dir | grep -b -o "/linux/" | awk 'BEGIN {FS=":"}{print $1}'`
	repo_dir=${script_dir:0:$length}"/linux"
	echo $repo_dir
}
