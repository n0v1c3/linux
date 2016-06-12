# Get working directory
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
length=`echo $script_dir | grep -b -o "/linux/" | awk 'BEGIN {FS=":"}{print $1}'`
repo_dir=${script_dir:0:$length}"/linux"


# Backup existing bashrc dotfile
mv ~/.bashrc ~/.bashrc-backup-$(date +%y%m%d-%H%M%S-%N)

# Add LINUX_DIR system variable to be used by the remaining files in this repository
sed "s|PATH=\$PATH:~/\.bin|&\nexport LINUX_DIR=${repo_dir}|" $repo_dir/home/.bashrc > ~/.bashrc

# Add custom PATH folder to bashrc and save into HOME directory
#sed "s|PATH=\$PATH:~/\.bin|&\nexport PATH=\$PATH:${repo_dir}/home/.bin|" /tmp/.bashrc > ~/.bashrc

rm ~/.bin/autolock
ln -s $repo_dir/scripts/bash/autolock.sh ~/.bin/autolock

# Run the bashrc dotfile to update current settings
source ~/.bashrc
