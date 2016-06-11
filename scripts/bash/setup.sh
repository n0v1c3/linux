# Get working directory
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
length=`echo $script_dir | grep -b -o "/linux/" | awk 'BEGIN {FS=":"}{print $1}'`
repo_dir=${script_dir:0:$length}"/linux"

# Backup existing bashrc dotfile
mv ~/.bashrc ~/.bashrc-backup-$(date +%y%m%d-%H%M%S-%N)

# Add custom PATH folder to bashrc and save into HOME directory
sed "s|PATH=\$PATH:~/\.bin|&\nexport PATH=\$PATH:${repo_dir}/config/bin|" $repo_dir/config/bash/bashrc > ~/.bashrc

# Run the bashrc dotfile to update current settings
source ~/.bashrc
