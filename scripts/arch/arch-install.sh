#!/bin/bash

# Remove username/password from ftp mount

# User enter disk path
echo -e "Please enter your full name: "
read nameFull
echo -e "Please enter your email: "
read email

echo -e "Please enter your username: "
read nameUser
echo -e "Please enter a hostname: "
read nameHost

echo -e "Please enter path to disk (/dev/sd[x]): "
read diskPath

# Partition disk
echo -e "o\nn\np\n1\n\n+100M\nn\np\n2\n\n+2G\nn\np\n3\n\n\na\n1\nt\n2\n82\nw\n" | fdisk ${diskPath}

# Swap file system
mkswap ${diskPath}2	# Make swap file system
swapon ${diskPath}2	# Turn swap file system on

# Create ext4 file system
mkfs.ext4 ${diskPath}3

# Mount new file system
mount ${diskPath}3 /mnt

# Use prebuilt mirrorlist
wget https://raw.githubusercontent.com/n0v1c3/arch-linux/master/pacman/mirrorlist
mkdir /mnt/etc/pacman.d
mv ./mirrorlist /mnt/etc/pacman.d/

# Rank provided mirrorlist by speed
#cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup             # Backup
#sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup             # Uncomment
#rankmirrors /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist  # Rank

# Install base Arch packages
pacstrap /mnt base

# Generate fstab
genfstab -p /mnt >> /mnt/etc/fstab

# chroot
#arch-chroot /mnt

# Set hostname
echo ${nameHost} > /mnt/etc/hostname

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

# Git - Distributed version control system
arch-chroot /mnt pacman -S --noconfirm git					# Install
arch-chroot /mnt git config --global user.email ${email}	# Set email
arch-chroot /mnt git config --global user.name ${nameFull}	# Set name

# Guake - Terminal
arch-chroot /mnt pacman -S --noconfirm guake                						# Install
cp /mnt/usr/share/applications/guake.desktop /mnt/etc/xdg/autostart/guake.desktop	# Autostart

# SLiM - Login Manager
arch-chroot /mnt pacman -S --noconfirm slim					# Install
arch-chroot /mnt systemctl enable slim.service				# Enable and load on boot
arch-chroot ln -s /usr/bin/slimlock /usr/local/bin/xflock4	# Overwrite default lock screen
echo "exec xfce4-session" > /mnt/root/.xinitrc				# Load xfce on login of root

# CurlFTPFS - FTP File System Manager
arch-chroot /mnt pacman -S --noconfirm curlftpfs																						# Install
echo "curlftpfs#rgretchen:Cycology1@ftp.cycologybikes.ca /mnt/cycology-ftp fuse auto,user,allow_other,_netdev 0 0" >> /mnt/etc/fstab	# Configure fstab

# Install custom tools
arch-chroot /mnt pacman -S --noconfirm baobab               # Disk usage analyzer
arch-chroot /mnt pacman -S --noconfirm clementine           # Music player
#arch-chroot /mnt pacman -S --noconfirm conky               # System monitor (side panel)
arch-chroot /mnt pacman -S --noconfirm deluge               # Bit torrent client
arch-chroot /mnt pacman -S --noconfirm firefox              # Web browser
arch-chroot /mnt pacman -S --noconfirm geany                # Text editor
arch-chroot /mnt pacman -S --noconfirm gnome-calculator     # Simple calcuator
arch-chroot /mnt pacman -S --noconfirm gnome-system-monitor # System monitor
arch-chroot /mnt pacman -S --noconfirm gparted              # Disk partition manager
arch-chroot /mnt pacman -S --noconfirm libreoffice          # Office documents
arch-chroot /mnt pacman -S --noconfirm openssh              # Secure shell
arch-chroot /mnt pacman -S --noconfirm remmina freerdp      # Remote desktop connection manager
arch-chroot /mnt pacman -S --noconfirm rsync                # Folder synchronization
arch-chroot /mnt pacman -S --noconfirm samba                # Windows network shares
arch-chroot /mnt pacman -S --noconfirm sshfs                # Secure shell file system
#arch-chroot /mnt pacman -S --noconfirm teamviewer          # Remote connections
arch-chroot /mnt pacman -S --noconfirm thunderbird          # Email client (replace with evolution)
arch-chroot /mnt pacman -S --noconfirm virtualbox           # System virtualization
arch-chroot /mnt pacman -S --noconfirm vlc                  # Media player
arch-chroot /mnt pacman -S --noconfirm wget					# Non-interactive network downloader
#arch-chroot /mnt pacman -S --noconfirm wine                # Windows "emulator"

########################################################################
# Bootloader
########################################################################

# Grub - Bootloader
arch-chroot /mnt pacman -S --noconfirm grub                 # Install
arch-chroot /mnt grub-install --target=i386-pc ${diskPath}	# Install grub into boot section of /dev/sd(x)
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg       # Set grub configuration

########################################################################
# Finished
########################################################################

mkdir /mnt/root/Documents/
git clone https://github.com/n0v1c3/arch-linux.git /mnt/root/Documents



# Directory variables
configDir=/mnt/root/.config/xfce4
backupDir=/mnt/root/Documents/arch-linux/xfce/config

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
