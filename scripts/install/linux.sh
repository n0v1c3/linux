#!/bin/bash

################################################################################
# linux.sh
# Install Arch Linux with desired software and configurations 
################################################################################
#
# TODO (160721) - Look at zsh installer found in the dotfiles repo
# TODO - Replace networkmanager with wicd and wicd-gtk
#
################################################################################

##
# Variables
##

sudo_gid=1000
install=true

if ( [[ $1 == '-t' ]] )
then
	install=false
fi

##
# Read
##

# Get directory of the current bash script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get user's information
echo -n "Enter disk path (/dev/sd[x]): "
read diskpath
echo -n "Enter hostname: "
read hostname
echo -n "Enter root password: "
read root_pass
echo -n "Enter username: "
read user_name
echo -n "Enter password: "
read user_pass
echo -n "Enter full name: "
read user_full
echo -n "Enter email: "
read user_email

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

# Install command to be used when installing new software
install_cmd="$sudo $installer"

##
# Disks
##

# Partition (100M Grub | 2G Swap | x ext)
echo -e "o\nn\np\n1\n\n+100M\nn\np\n2\n\n+2G\nn\np\n3\n\n\na\n1\nt\n2\n82\nw\n" | fdisk ${diskpath}

# Swap file system
mkswap ${diskpath}2
swapon ${diskpath}2

# Create ext4 file system
mkfs.ext4 ${diskpath}3

# Mount new file system
mount ${diskpath}3 /mnt

##
# Base
##

# Rank mirrors by speed
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 16 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# Kernel
$base_install

# Timezone
$sudo ln -s /usr/share/zoneinfo/Canada/Mountain /mnt/etc/localtime

# Configure locales
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /mnt/etc/locale.gen
$sudo locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf

##
# Network
##

# Generate fstab
genfstab -p /mnt >> /mnt/etc/fstab

# Set hostname
echo $hostname > /mnt/etc/hostname

# Enable DHCP
$sudo systemctl enable dhcpcd.service

##
# Install
##

# Grub
$install_cmd grub

# xSessio
#$install_cmd i3 # i3lock package corrupted
$install_cmd i3-wm
$install_cmd i3status
$install_cmd xorg

# Terminal tools
$install_cmd alsa-utils	# Advanced linux sound architecture
$install_cmd git
$install_cmd lm_sensors	# Linux monitoring sensors
$install_cmd networkmanager
$install_cmd network-manager-applet
$install_cmd python
$install_cmd sudo
$install_cmd tmux
$install_cmd vim
$install_cmd wget
$install_cmd xrandr
$install_cmd zsh

# xSession tools
$install_cmd arandr
$install_cmd dmenu
$install_cmd firefox
$install_cmd gnome-icon-theme-full
$install_cmd slim
$install_cmd terminator
$install_cmd thunar

if ( $install )
then
	$install_cmd curl
	$install_cmd curlftpfs
	$install_cmd ghostscript # Used for imaagemagick
	$install_cmd openssh
	$install_cmd ranger
	$install_cmd rsync
	$install_cmd samba
	$install_cmd sshfs

	$install_cmd baobab		# Disk usage
	$install_cmd clementine
	$install_cmd conky
	$install_cmd deluge
	$install_cmd freerdp
	$install_cmd fslint		# File compare
	$install_cmd gource
	$install_cmd imagemagick
	$install_cmd libreoffice
	$install_cmd remmina
	$install_cmd retext
	$install_cmd scrot		# Screen shot
	$install_cmd virtualbox
	$install_cmd vlc
	$install_cmd xautolock
fi

##
# Configuration
##

# Git
$sudo git config --global user.email ${user_email}
$sudo git config --global user.name ${user_full}

# Groups
$sudo groupadd -g $sudo_gid sudo

# Grub
$sudo grub-install --target=i386-pc ${diskpath}
$sudo grub-mkconfig -o /boot/grub/grub.cfg

# Linux repository
mkdir --parents /mnt/home/$user_name/Documents/development
$sudo git clone https://github.com/n0v1c3/linux.git /home/$user_name/Documents/development/linux

# Linux monitoring sensors
$sudo sensors-detect --auto

# NetworkManager - Enable load on boot
$sudo systemctl enable NetworkManger

# Oh-My-ZSH
$sudo git clone git://github.com/robbyrussell/oh-my-zsh.git /bin/.oh-my-zsh

# Root
echo "root:$root_pass" | $sudo /usr/sbin/chpasswd

# SLiM
$sudo systemctl enable slim.service
ln -s /usr/bin/slimlock /mnt/usr/local/bin/xflock4

# User
$sudo useradd -m -g users -s /bin/bash $user_name
echo "$user_name:$user_pass" | $sudo /usr/sbin/chpasswd
$sudo usermod -a -G sudo $user_name

# Virtualbox guest
$install_cmd virtualbox-guest-modules-arch

##
# Dotfiles
##

# Root dotfiles
$sudo mkdir --parents /root/Documents/development
$sudo git clone https://github.com/n0v1c3/dotfiles.git /root/Documents/development/dotfiles
$sudo bash /root/Documents/development/dotfiles/scripts/dot-install.sh -l

# User dotfiles
$sudo mkdir --parents /home/$user_name/Documents/development
$sudo git clone https://github.com/n0v1c3/dotfiles.git /home/$user_name/Documents/development/dotfiles
$sudo bash /home/$user_name/Documents/development/dotfiles/scripts/dot-install.sh -u $user_name -l

##
# Clean-up
##

# Proper owner for all of user's home directory
$sudo chown -R $user_name:root /home/$user_name

# Proper owner for sudoers file as root
$sudo chown root:root /home/$user_name/Documents/development/dotfiles/config/etc/sudoers
