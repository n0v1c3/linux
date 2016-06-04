#!/bin/bash

source repo-dir.sh
parent_dir=echo $(repoDir)

echo -e "Please enter a hostname: "
read nameHost

# User enter disk path
echo -e "Please enter your full name: "
read nameFull
echo -e "Please enter your email: "
read email

# Use prebuilt mirrorlist
wget https://raw.githubusercontent.com/n0v1c3/linux/master/config/pacman/mirrorlist
mkdir /mnt/etc/pacman.d
mv ./mirrorlist /mnt/etc/pacman.d/

# Rank provided mirrorlist by speed
#cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup             # Backup
#sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup             # Uncomment
#rankmirrors /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist  # Rank

# Install base Arch packages
pacstrap /mnt base

# Set timezone
arch-chroot /mnt ln -s /usr/share/zoneinfo/Canada/Mountain /mnt/etc/localtime

# Configure locales
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /mnt/etc/locale.gen	# Write desired locales
arch-chroot /mnt locale-gen											# Generate locales
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf						# Set LANG

# Configure networkd DHCP
arch-chroot /mnt systemctl enable dhcpcd.service

# Base required xfce4 installation
arch-chroot /mnt pacman -S --noconfirm xfce4-session     # Session manager
arch-chroot /mnt pacman -S --noconfirm xfdesktop         # Desktop manager
arch-chroot /mnt pacman -S --noconfirm xfwm4             # Window manager
arch-chroot /mnt pacman -S --noconfirm xfce4-panel       # Panel manager
arch-chroot /mnt pacman -S --noconfirm xfce4-settings    # Default setting applications

# Xorg
arch-chroot /mnt pacman -S --noconfirm xorg

########################################################################
# Tools
########################################################################

# Screenshot
arch-chroot /mnt pacman -S --noconfirm xfce4-screenshooter

# Virtualbox - Guest
arch-chroot /mnt pacman -S --noconfirm virtualbox-guest-utils virtualbox-guest-modules virtualbox-guest-dkms
echo -e "vboxguest\nvboxsf\nvboxvideo" > /mnt/etc/modules-load.d/virtualbox.conf

########################################################################
# Software
########################################################################

# CurlFTPFS - FTP File System Manager
arch-chroot /mnt pacman -S --noconfirm curlftpfs

# Git - Distributed version control system
arch-chroot /mnt pacman -S --noconfirm git
arch-chroot /mnt git config --global user.email ${email}
arch-chroot /mnt git config --global user.name ${nameFull}

# Linux repository
mkdir /mnt/root/Documents/
git clone https://github.com/n0v1c3/linux.git /mnt/root/Documents

# Guake - Terminal
arch-chroot /mnt pacman -S --noconfirm guake
cp /mnt/usr/share/applications/guake.desktop /mnt/etc/xdg/autostart/guake.desktop

# SLiM - Login manager
arch-chroot /mnt pacman -S --noconfirm slim
arch-chroot /mnt systemctl enable slim.service
ln -s /usr/bin/slimlock /mnt/usr/local/bin/xflock4
echo "exec xfce4-session" > /mnt/root/.xinitrc

# sudo - Substitute user do
arch-chroot /mnt pacman -S --noconfirm sudo
echo "$nameUser ALL=(ALL) ALL" >> /mnt/etc/sudoers

# Terminator - Terminal emulator
arch-chroot /mnt pacman -S --noconfirm terminator
mkdir /mnt/root/.config/terminator
cp /mnt/root/Documents/linux/config/terminator/config /mnt/root/.config/terminator/config
mkdir /mnt/home/$nameUser/.config/terminator
cp /mnt/root/Documents/linux/config/terminator/config /mnt/home/$nameUser/.config/terminator/config


########################################################################
# Finished
########################################################################

# Directory variables
configDir=/mnt/root/.config/xfce4
backupDir=/mnt/root/Documents/linux/config/xfce

# Backup current panel configuration
cp $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml.backup

# Remove existing panel configuration
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# Remove existing launcher configuration
rm -r $configDir/panel/

# Copy desired panel configuration
cp $backupDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# Copy desired panel launchers
cp -r $backupDir/panel $configDir

# Create local backup of keyboard shortcuts
cp $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml.backup

# Remove existing keyboard shortcuts configuration
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

# Copy desired keyboard-shortcus configuration
cp $backupDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

########################################################################
# Desktop
########################################################################

# Remove existing temporary panel configuration backups
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml.backup

# Backup current panel configuration
cp $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml.backup

# Remove existing panel configuration
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

# Copy desired panel configuration
cp $backupDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

echo -e "\nInstallation Complete\n"	# Message
sleep 1								# Delay

#wget https://raw.githubusercontent.com/n0v1c3/arch-linux/master/xfce/xfce-restore.sh
#reboot								# Reboot
