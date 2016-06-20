#!/bin/bash

# 1 - Detect current os
# 2 - Partition and format desired drive
# 3 - Configure default network configuration
# 4 - Create user
# 5 - Configure clock
# 6 - Configure language

# Get directory of the current bash script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 2
# Partition disk (disk to be selected by user and should be known in advance)
# The new ext4 file system will be mounted directly on /mnt
echo -n "Enter disk path (/dev/sd[x]): "
read diskpath
source $DIR/disk-partition.sh $diskpath

# 3
echo -n "Enter hostname: "
read hostname

# 4
echo -n "Enter username: "
read user_name
echo -n "Enter full name: "
read user_full
echo -n "Enter email: "
read user_email

# 1
# Set parameters based on the current operating system
case $(uname -a | tr '[:upper:]' '[:lower:]') in

	# Arch OS
	*arch*)
		os="arch"
		sudo="arch-chroot /mnt"
		installer="pacman -S --noconfirm"
		pacstrap /mnt base
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

# 5
# Set timezone
$sude ln -s /usr/share/zoneinfo/Canada/Mountain /mnt/etc/localtime

# 6
# Configure locales
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf

# Grub - Bootloader
$install_cmd grub
$sudo grub-install --target=i386-pc ${diskpath}
$sudo grub-mkconfig -o /boot/grub/grub.cfg

# Initialize network configuration
source $DIR/network-config.sh $hostname

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
