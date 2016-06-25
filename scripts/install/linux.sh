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
echo -n "Enter password: "
read user_pass
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
		base_install="pacstrap /mnt base"
		;;

	# Ubuntu OS
	*ubuntu*)
		os="ubuntu"
		sudo="sudo"
		installer="apt-get -y"
		base_install=""
		;;

	# Invalid OS
	*)
		echo "Invalid OS"
		exit 1
		;;
esac

# Install base kernel
$base_install

# Install command to be used when installing new software
install_cmd="$sudo $installer install"

# 5
# Set timezone
$sudo ln -s /usr/share/zoneinfo/Canada/Mountain /mnt/etc/localtime

# 6
# Configure locales
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf

# Grub - Bootloader
$install_cmd grub
$sudo grub-install --target=i386-pc ${diskpath}
$sudo grub-mkconfig -o /boot/grub/grub.cfg

# User - Add user and set password
$sudo useradd -m -g users -s /bin/bash $user_name 
#$sudo $(echo "$user_name:$user_pass" | chpasswd)
echo "$user_name:$user_pass" | $sudo /usr/sbin/chpasswd

# Initialize network configuration
source $DIR/network-config.sh $hostname

# Install xSession
$install_cmd i3
$install_cmd xorg
$sudo xinit i3

# Terminal tools
$install_cmd curl	# FTP application
$install_cmd curlftpfs	# FTP file-system
$install_cmd git	# Git
$install_cmd openssh	# SSH
$install_cmd python	# Python
$install_cmd ranger	# File manager
$install_cmd rsync	# Folder sync
$install_cmd samba	# Windows shares
$install_cmd sshfs	# SSH mounts
$install_cmd sudo	# Substitute user do
$install_cmd vim	# Text editor
$install_cmd wget	# FTP application
$install_cmd xrandr	# Monitor configuration

# xSession tools
$install_cmd i3
$install_cmd arandr		# Monitor configuration
$install_cmd baobab		# Disk usage
$install_cmd clementine		# Music player
$install_cmd deluge		# Bit torrent
$install_cmd firefox		# Web browser
$install_cmd freerdp		# RDP protocol
$install_cmd imagemagick	# Image manipulation
$install_cmd libreoffice	# Office suite
$install_cmd remmina		# RDP client
$install_cmd scrot		# Screen shot
$install_cmd terminator		# Terminal emulator
$install_cmd virtualbox		# System virtualization
$install_cmd vlc		# Media player
$install_cmd xautolock		# Session lockout

# Configuration

# Git
$sudo git config --global user.email ${user_email}
$sudo git config --global user.name ${user_full}

# Linux repository
mkdir /mnt/home/$user_name/Documents/development
git clone https://github.com/n0v1c3/linux.git /mnt/home/$user_name/Documents/development

# Virtualbox - Guest
$install_cmd virtualbox-guest-utils virtualbox-guest-modules virtualbox-guest-dkms
echo -e "vboxguest\nvboxsf\nvboxvideo" > /mnt/etc/modules-load.d/virtualbox.conf

