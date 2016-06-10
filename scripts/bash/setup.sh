# Get working directory
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
length=`echo $script_dir | grep -b -o "/linux/" | awk 'BEGIN {FS=":"}{print $1}'`
repo_dir=${script_dir:0:$length}"/linux"

# Backup existing bashrc dotfile
mv ~/.bashrc ~/.bashrc-backup-$(date +%y%m%d-%H%M%S-%N)
cp $repo_dir/config/bash/bashrc ~/.bashrc

source ~/.bashrc
