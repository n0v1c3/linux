#!/bin/bash

# Name: linux/scripts/install/linux.sh
# Description: Install Arch Linux with desired software and configurations 

###
# Variables
###

# Disk partition
disk_partition="o\nn\np\n1\n\n+100M\nn\np\n2\n\n+4G\nn\np\n3\n\n\na\n1\nt\n2\n82\nw\n"

# Sudo gid
sudo_gid=101

# Common commands
sudo="arch-chroot /mnt"
installer="pacman -S --noconfirm"
base_install="pacstrap /mnt base"
install_cmd="$sudo $installer"

# Prompts
prompt_device="Select device for installation: "
prompt_host="Enter hostname: "
prompt_root="Enter root password: "
prompt_reroot="Re-enter root password: "
prompt_user="Enter primary username: "
prompt_git="Enter git username: "
prompt_pass="Enter primary password: "
prompt_repass="Re-enter primary password: "
prompt_full="Enter user's full name: "
prompt_email="Enter user's email address: "
prompt_rank="Ranking pacman mirrors by connection speed... (This will take a while!)"

# Files
file_mirrors=/etc/pacman.d/mirrorlist

###
# Read
###

# Get installation information
echo $prompt_device
select disk in $(lsblk -ndl --output NAME)
do
    diskpath=/dev/$disk
    break
done

echo -n $prompt_host;  read hostname
echo -n $prompt_root;  read -s root_pass
echo ""
echo -n $prompt_user;  read user_name
echo -n $prompt_pass;  read -s user_pass
echo ""
echo -n $prompt_git;   read git_user
echo -n $prompt_full;  read user_full
echo -n $prompt_email; read user_email

###
# Disks
###

# Partition (100M Grub | 4G Swap | x ext)
echo -e $disk_partition | fdisk ${diskpath}

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

# TODO [170509] - Can reflector be used here?
# Rank mirrors by speed 
echo $prompt_rank
cp $file_mirrors $file_mirrors.backup
sed -i 's/^#Server/Server/' $file_mirrors.backup
rankmirrors -v -n 16 $file_mirrors.backup > $file_mirrors

# Kernel
$base_install

# Pacman mirrors
cp $file_mirrors /mnt$file_mirrors

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
$install_cmd xorg-xinit

# Terminal tools
$install_cmd apache         # Web server
$install_cmd alsa-utils     # Advanced linux sound architecture
$install_cmd bluez          # Bluetooth protocol stack
$install_cmd bluez-utils    # Bluetooth bluetoothctl utility
$install_cmd colordiff      # Display diff using git colors
$install_cmd cronie         # Cronjob task manager
$install_cmd curl           # Server exchange requests/responses
$install_cmd curlftpfs      # Mount for FTP
$install_cmd fdupes         # Duplicate file search
$install_cmd fuse           # Mount for ntfs
$install_cmd git            # Git
$install_cmd gzip           # Gzip
$install_cmd lm_sensors     # Linux monitoring sensors
$install_cmd mariadb        # MySQL database
$install_cmd networkmanager # NetworkManager service
$install_cmd ntfs-3g        # Mount for ntfs
$install_cmd openssh        # SSH  
$install_cmd pandoc         # General markup converter
$install_cmd php            # General markup converter
$install_cmd php-apache     # General markup converter
$install_cmd phpmyadmin     # PHP based database management
$install_cmd python         # Python
$install_cmd reflector      # Pacman mirror update tool
$install_cmd rsync          # Rsync
$install_cmd ruby           # Ruby
$install_cmd samba          # Mount Windows network shares
$install_cmd sshfs          # Mount SSH
$install_cmd sudo           # Sudo
$install_cmd tmux           # Tmux
$install_cmd vim            # Vim
$install_cmd wget           # Server download requests
$install_cmd zip            # Zip
$install_cmd zsh            # Zsh

# xSession tools
$install_cmd arandr                 # Display configuration
$install_cmd baobab                 # Disk usage
$install_cmd cbatticon              # Tray icon
$install_cmd conky                  # Interactive background display
$install_cmd deluge                 # Torrent
$install_cmd dmenu                  # Application launcher
$install_cmd firefox                # Firefox
$install_cmd gnome-icon-theme-full  # Icon pack
$install_cmd gource                 # Fun tool for git repositories
$install_cmd libreoffice            # LibreOffice
$install_cmd network-manager-applet # Tray icon
$install_cmd remmina                # Remote connection interface
$install_cmd retext                 # Markdown editor / viewer
$install_cmd scrot                  # Screen shot
$install_cmd synergy                # Network mouse/keyboard share
$install_cmd terminator             # Terminal
$install_cmd thunar                 # File browser
$install_cmd virtualbox             # Virtualbox
$install_cmd xautolock              # Screen autolock

###
# Dotfiles
###

# n0v1c3 development path
n0v1c3=/home/$user_name/Documents/development/n0v1c3

# TODO [170511] - Add all repos (see: https://api.github.com/users/n0v1c3/repos)
# User dotfiles
$sudo mkdir --parents $n0v1c3
$sudo git clone https://github.com/$git_user/linux.git $n0v1c3/linux

# Add home links
path=$n0v1c3/linux/dotfiles/home
for file in $($sudo find $path -maxdepth 1 -iname '*' -not -path $path/.config); do
    $sudo ln -s $file /home/$user_name/$(basename $file)
done

# Add home/.config links
$sudo mkdir /home/$user_name/.config
for file in $($sudo find $path/.config -maxdepth 1 -iname '*' -not -path $path/.config); do
    $sudo ln -s $file /home/$user_name/.config/$(basename $file)
done

# Make copy of etc templates
path="$n0v1c3/linux/dotfiles/etc/"
for file in $($sudo find $path -type f -iname '*'); do
    $sudo cp $file /etc/${file#$path}
done

###
# Configuration
###

# Apache
# TODO [170518] - Apache configuration (/etc/httpd/conf/httpd.conf)
$sudo systemctl enable httpd

# Cronie
$sudo systemctl enable cronie
$sudo echo "MAILTO=\"$user_email\"\n$(cat $n0v1c3/linux/dotfiles/home/.config/cron/crontab.txt)" | crontab

# Git
$sudo git config --global user.email ${user_email}
$sudo git config --global user.name ${user_full}

# Groups
$sudo groupadd -g $sudo_gid sudo

# Grub
$sudo grub-install --target=i386-pc ${diskpath}
$sudo grub-mkconfig -o /boot/grub/grub.cfg

# Linux monitoring sensors
$sudo sensors-detect --auto

# MariaDB
# TODO [170518] - Add $user_name to MySQL users
$sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
$sudo systemctl enable mariadb
$sudo mysql_secure_installation

# NetworkManager - Enable load on boot
$sudo systemctl enable NetworkManger

# Oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# PHP
$sudo sed -i '/^#.*LoadModule mpm_event_module/s/^#//' /etc/httpd/conf/httpd.conf
$sudo sed -i '/^LoadModule mpm_preford_module/s/^#*/#/' /etc/httpd/conf/httpd.conf
$sudo echo "LoadModule php7_module modules/libphp7.so" >> /etc/httpd/conf/httpd.conf
$sudo echo "AddHandler php7-script php" >> /etc/httpd/conf/httpd.conf
$sudo echo "Include conf/extra/php7_module.conf" >> /etc/httpd/conf/httpd.conf
$sudo sed -i '/^;.*extension=pdo_mysql.so/s/^;//' /etc/php/php.ini
$sudo sed -i '/^;.*extension=mysqli.so/s/^;//' /etc/php/php.ini

# phpMyAdmin
# TODO [170519] - Add apache configuration

# Powerline fonts
$sudo clone https://github.com/powerline/fonts.git
$sudo ./fonts/install.sh
$sudo rm -rf fonts

# Root password
echo "root:$root_pass" | $sudo /usr/sbin/chpasswd

# User groups and password
$sudo useradd -m -g $user_name -s /bin/zsh $user_name
echo "$user_name:$user_pass" | $sudo /usr/sbin/chpasswd
$sudo usermod -a -G sudoers $user_name
$sudo echo "%sudoers ALL=(ALL) ALL" >> /etc/sudoers

# Virtualbox guest
$install_cmd virtualbox-guest-modules-arch

###
# Clean-up
###

# Proper owner for all of user's home directory
$sudo chown -R $user_name:users /home/$user_name
