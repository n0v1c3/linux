#!/bin/bash

# Name: linux/scripts/install/linux.sh
# Description: Install Arch Linux with desired software and configurations 

###
# Variables
###

sudo_gid=1000

###
# Read
###

# Get directory of the current bash script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Echo readable layout of available hard drives to be formatted
lsblk

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

sudo="arch-chroot /mnt"
installer="pacman -S --noconfirm"
base_install="pacstrap /mnt base"

# Install command to be used when installing new software
install_cmd="$sudo $installer"

###
# Disks
###

# Partition (100M Grub | 2G Swap | x ext)
echo -e "o\nn\np\n1\n\n+100M\nn\np\n2\n\n+2G\nn\np\n3\n\n\na\n1\nt\n2\n82\nw\n" | fdisk ${diskpath}

# Swap file system
mkswap ${diskpath}2
swapon ${diskpath}2

# Create ext4 file system
mkfs.ext4 ${diskpath}3

# Mount new file system
mount ${diskpath}3 /mnt

###
# Base
###

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

###
# Network
###

# Generate fstab
genfstab -p /mnt >> /mnt/etc/fstab

# Set hostname
echo $hostname > /mnt/etc/hostname

# Enable DHCP
$sudo systemctl enable dhcpcd.service

###
# Software
###

# Grub
$install_cmd grub

# xSession
$install_cmd i3
$install_cmd i3-wm
$install_cmd i3status
$install_cmd xorg

# Terminal tools
$install_cmd alsa-utils # Advanced linux sound architecture
$install_cmd bluez # Bluetooth protocol stack
$install_cmd bluez-utils # Bluetooth bluetoothctl utility
$install_cmd colordiff # Display diff using git colors
$install_cmd cronie # Cronjob task manager
$install_cmd curl # URL data transfer
$install_cmd curlftpfs # FTP using curl
$install_cmd fuse # Mount for ntfs
$install_cmd ghostscript # Used for imagemagick
$install_cmd git
$install_cmd lm_sensors # Linux monitoring sensors
$install_cmd networkmanager
$install_cmd ntfs-3g # Mount for ntfs
$install_cmd openssh
$install_cmd pandoc # General markup converter
$install_cmd python
$install_cmd ranger
$install_cmd rsync
$install_cmd samba
$install_cmd sshfs
$install_cmd sudo
$install_cmd tmux
$install_cmd vim
$install_cmd wget
$install_cmd xrandr

# xSession tools
$install_cmd arandr
$install_cmd baobab # Disk usage
$install_cmd cbatticon
$install_cmd clementine
$install_cmd conky
$install_cmd deluge
$install_cmd dmenu
$install_cmd fdupes
$install_cmd firefox
$install_cmd freerdp
$install_cmd fslint # File compare
$install_cmd gnome-icon-theme-full
$install_cmd gource
$install_cmd imagemagick
$install_cmd libreoffice
$install_cmd network-manager-applet
$install_cmd remmina
$install_cmd retext
$install_cmd scrot # Screen shot
$install_cmd terminator
$install_cmd thunar
$install_cmd virtualbox
$install_cmd vlc
$install_cmd xautolock

###
# Configuration
###

# Cronie
$sudo systemctl enable cronie

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

# Root
echo "root:$root_pass" | $sudo /usr/sbin/chpasswd

# User
$sudo useradd -m -g users -s /bin/bash $user_name
echo "$user_name:$user_pass" | $sudo /usr/sbin/chpasswd
$sudo usermod -a -G sudo $user_name

# Virtualbox guest
$install_cmd virtualbox-guest-modules-arch

###
# Dotfiles
###

# User dotfiles
$sudo mkdir --parents $n0v1c3
$sudo git clone https://github.com/n0v1c3/linux.git $n0v1c3/linux

# Add home links
for file in $(find $n0v1c3/linux/dotfiles/home -maxdepth 1 -iname '*' -not -path $n0v1c3/linux/dotfiles/home/.config); do
    $sudo ln -s $file /home/$username/$(basename $file)
done

# Add home/.config links
for file in $(find $n0v1c3/linux/dotfiles/home/.config -maxdepth 1 -iname '*' -not -path $n0v1c3/linux/dotfiles/home/.config); do
    $sudo ln -s $file /home/$username/.config/$(basename $file)
done

###
# Clean-up
###

# Proper owner for all of user's home directory
$sudo chown -R $user_name:users /home/$user_name
