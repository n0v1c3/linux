#!/bin/bash

# Get directory of the current bash script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get current OS information and convert to lowercase
os=$(uname -a | tr '[:upper:]' '[:lower:]')

# Set parameters based on the current operating system
case $os in

	# Arch OS
	*arch*)
		os="arch"
		sudo="arch-chroot /mnt"
		installer="pacman -S --noconfirm"
		;;

	# Ubuntu OS
	*ubuntu*)
		os="ubuntu"
		sudo="sudo"
		installer="apt-get -y"
		;;

	# Invalid OS
	*)
		echo "Invalid OS"
		exit 1
esac

# Install command to be used when installing new software
install_cmd="$sudo $installer install"

# Partition disk (disk to be selected by user and should be known in advance)
source $DIR/disk.sh

# Grub - Bootloader
$install_cmd grub
$sudo grub-install --target=i386-pc ${diskpath}
$sudo grub-mkconfig -o /boot/grub/grub.cfg

# Git

# Only push current branch to the corresponding remote branch that 'git pull' uses to update the current branch (this takes effect starting in Git 2.0)
# Set to 'matching' to maintain pre 2.0 behavior, git will push local branches to the remote branches that already exist with the same name
git config --global push.default simple

# Default window manager
$install_cmd i3

# Default terminal editor
$install_cmd vim

# Default terminal file browser
$install_cmd ranger

# Custom lock screen
$install_cmd i3lock
$install_cmd scrot
$install_cmd imagemagick
$install_cmd xautolock
