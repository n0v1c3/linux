#!/bin/bash

# Name: linux/scripts/install/linux.sh
# Description: Install Arch Linux with desired software and configurations
# Author: Travis Gall (n0v1c3)

# Section: Variables  {{{1
# TODO-TJG [171128] - Make this human readable
# Disk partition, yup that will do it
disk_partition="o\nn\np\n1\n\n+100M\nn\np\n2\n\n\
+4G\nn\np\n3\n\n\na\n1\nt\n2\n82\nw\n"

# Sudo gid
sudo_gid=101
user_gid=1000

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
prompt_user="Enter administrator username: "
prompt_pass="Enter administrator password: "
prompt_repass="Re-enter administrator password: "
prompt_git="Enter git username: "
prompt_full="Enter user's full name: "
prompt_email="Enter user's email address: "
prompt_rank="Ranking pacman mirrors by connection speed..."

# Update mirrors to private maintained list
file_mirrors=/etc/pacman.d/mirrorlist
wget https://raw.githubusercontent.com/n0v1c3/linux/master/dotfiles/etc/pacman.d/mirrorlist
mv ./mirrorlist "$file_mirrors"

# Section: Read {{{1
# Get installation information
echo "$prompt_device"
select disk in $(lsblk -ndl --output NAME)
do
    diskpath=/dev/$disk
    break
done

echo -n "$prompt_host";  read -r hostname
while [ -z "${root_pass}" ] || [ "$root_pass" != "$root_repass" ]; do
    echo -n "$prompt_root";  read -rs root_pass
    echo ""
    echo -n "$prompt_reroot";  read -rs root_repass
done
echo ""
echo -n "$prompt_user";  read -r user_name
while [ -z "${user_pass}" ] || [ "$user_pass" != "$user_repass" ]; do
    echo -n "$prompt_pass";  read -rs user_pass
    echo ""
    echo -n "$prompt_repass";  read -rs user_repass
done
echo ""
echo -n "$prompt_git";   read -r git_user
echo -n "$prompt_full";  read -r user_full
echo -n "$prompt_email"; read -r user_email

# Section: Disks {{{1
# Partition (100M Grub | 4G Swap | x ext)
echo -e "$disk_partition" | fdisk "${diskpath}"

# Swap file system
mkswap ${diskpath}2
swapon ${diskpath}2

# Create ext4 file system
mkfs.ext4 ${diskpath}3

# Mount new file system
mount ${diskpath}3 /mnt

# Section: Base {{{1
# Enusre latest pacman keys are installed
# NOTE - Added for error installing using an older live iso
gpg --refresh-keys
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys

# TODO-TJG [180903] - Move this to a maintenance script
# Rank mirrors by speed
# echo "$prompt_rank"
# cp "/$file_mirrors" "/$file_mirrors.backup"
# sed -i 's/^#Server/Server/' "/$file_mirrors.backup"
# rankmirrors -v -n 16 "/$file_mirrors.backup" > "/$file_mirrors"

# Kernel
$base_install

# Use private mirror list post install
cp "/$file_mirrors" "/mnt/$file_mirrors"

# Timezone
$sudo ln -s /usr/share/zoneinfo/Canada/Mountain /mnt/etc/localtime

# Configure locales
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /mnt/etc/locale.gen
$sudo locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf

# Section: Network {{{1
# Generate fstab
genfstab -p /mnt >> /mnt/etc/fstab

# Set hostname
echo "$hostname" > /mnt/etc/hostname

# Enable DHCP
$sudo systemctl enable dhcpcd.service

# Section: Software {{{1
# Grub
$install_cmd grub

# xSession
# $install_cmd i3
$install_cmd i3-wm
$install_cmd i3blocks
$install_cmd i3status
$install_cmd xorg
$install_cmd xorg-xinit

# Terminal tools
# $install_cmd apache         # Web server
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
# $install_cmd mariadb        # MySQL database
$install_cmd networkmanager # NetworkManager service
$install_cmd ntfs-3g        # Mount for ntfs
$install_cmd openssh        # SSH
# $install_cmd pandoc         # General markup converter
# $install_cmd php            # PHP
# $install_cmd php-apache     # PHP Apache
# $install_cmd phpmyadmin     # PHP based database management
$install_cmd python         # Python
$install_cmd reflector      # Pacman mirror update tool
$install_cmd rsync          # Rsync
# $install_cmd ruby           # Ruby
$install_cmd samba          # Mount Windows network shares
$install_cmd sshfs          # Mount SSH
$install_cmd sudo           # Sudo
$install_cmd tmux           # Tmux
$install_cmd vim            # Vim
$install_cmd wget           # Server download requests
$install_cmd zip            # Zip
$install_cmd zsh            # Zsh

# xSession tools
# $install_cmd arandr                 # Display configuration
# $install_cmd baobab                 # Disk usage
$install_cmd cbatticon              # Tray icon
# $install_cmd conky                  # Interactive background display
# $install_cmd deluge                 # Torrent
$install_cmd dmenu                  # Application launcher
$install_cmd firefox                # Firefox
$install_cmd gnome-icon-theme-full  # Icon pack
# $install_cmd gource                 # Fun tool for git repositories
# $install_cmd librecad               # Drafting tools
# $install_cmd libreoffice            # LibreOffice
$install_cmd network-manager-applet # Tray icon
# $install_cmd remmina                # Remote connection interface
# $install_cmd retext                 # Markdown editor / viewer
$install_cmd scrot                  # Screen shot
# $install_cmd synergy                # Network mouse/keyboard share
$install_cmd terminator             # Terminal
$install_cmd thunar                 # File browser
# $install_cmd virtualbox             # Virtualbox
$install_cmd xautolock              # Screen autolock

# Section: Dotfiles {{{1
# n0v1c3 development path
n0v1c3=/home/$user_name/Documents/development/n0v1c3

# User dotfiles
$sudo mkdir --parents "$n0v1c3"
$sudo git clone "https://github.com/$git_user/linux.git" "$n0v1c3/linux"

# Add home links
path=$n0v1c3/linux/dotfiles/home
for file in \
    $($sudo find "$path" -maxdepth 1 -iname '*' -not -path "$path/.config")
do
    $sudo ln -s "$file" /home/"$user_name"/"$(basename "$file")"
done

# Add link to .config
$sudo mkdir "/home/$user_name/.config"
for file in \
    $($sudo find "$path/.config" -maxdepth 1 -iname '*')
do
    $sudo ln -s "$file" "/home/$user_name/.config/$(basename "$file")"
done

# Blank folder for histories
$sudo mkdir --parents "/home/$user_name/.config/history"
$sudo mkdir --parents "/home/$user_name/.config/history/zsh"

# Blank file for .Xauthority
$sudo mkdir --parents "/home/$user_name/.config/xsession"
$sudo touch "/home/$user_name/.config/xsession/.Xauthority"

# Add cron links
path="$n0v1c3/linux/dotfiles/var/spool/cron"
for file in \
    $($sudo find "$path" -maxdepth 1 -iname '*')
do
    filename="$(basename "$file")"
    $sudo ln -s "$file" /var/spool/cron/"$filename"
    $sudo chown "$filename":"$filename" /var/spool/cron/"$filename"
done

# Make copy of etc templates
path="$n0v1c3/linux/dotfiles/etc/"
for file in $($sudo find "$path" -type f -iname '*'); do
    $sudo cp "$file" "/etc/${file#$path}"
done

# Clone required vim bundles
bundles=/home/$user_name/.vim/bundle
github="https://github.com"
mkdir "$bundles"
$sudo git clone "$github/kien/ctrlp.vim.git" "$bundles/ctrlp.vim"
$sudo git clone "$github/scrooloose/nerdcommenter.git" "$bundles/nerdcommenter"
$sudo git clone "$github/scrooloose/nerdtree.git" "$bundles/nerdtree"
$sudo git clone "$github/ervandew/supertab.git" "$bundles/supertab"
$sudo git clone "$github/vim-syntastic/syntastic.git" "$bundles/syntastic"
$sudo git clone "$github/tpope/vim-fugitive.git" "$bundles/vim-fugitive"
$sudo git clone "$github/tpope/vim-surround.git" "$bundles/vim-surround"
$sudo git clone "$github/Kuniwak/vint.git" "$bundles/vint"

# Section: Configuration {{{1
# Apache
$sudo systemctl enable httpd

# Cronie
$sudo systemctl enable cronie

# Git
$sudo git config --global user.email "${user_email}"
$sudo git config --global user.name "${user_full}"

# Groups
$sudo groupadd -g $sudo_gid sudo
$sudo groupadd -g $user_gid $user_name

# Grub
$sudo grub-install --target=i386-pc "${diskpath}"
$sudo grub-mkconfig -o /boot/grub/grub.cfg

# Linux monitoring sensors
$sudo sensors-detect --auto

# MariaDB
# TODO [170518] - Add $user_name to MySQL users
# $sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
# $sudo systemctl enable mariadb
# $sudo mysql_secure_installation

# NetworkManager - Enable load on boot
$sudo systemctl enable NetworkManger

# Oh-my-zsh
githubuser="https://raw.githubusercontent.com"
$sudo sh -c "$(wget $githubuser/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
$sudo mv /root/.oh-my-zsh /usr/share/oh-my-zsh

# PHP
$sudo sed -i '/^#.*LoadModule mpm_event_module/s/^#//' \
/etc/httpd/conf/httpd.conf
$sudo sed -i '/^LoadModule mpm_preford_module/s/^#*/#/' \
/etc/httpd/conf/httpd.conf
$sudo echo "LoadModule php7_module modules/libphp7.so\n" . \
"AddHandler php7-script php\n" .
"Include conf/extra/php7_module.conf" >> /etc/httpd/conf/httpd.conf
$sudo sed -i '/^;.*extension=pdo_mysql.so/s/^;//' /etc/php/php.ini
$sudo sed -i '/^;.*extension=mysqli.so/s/^;//' /etc/php/php.ini

# phpMyAdmin
# Powerline fonts
$sudo clone https://github.com/powerline/fonts.git
$sudo ./fonts/install.sh
$sudo rm -rf fonts

# Root password
echo "root:$root_pass" | $sudo /usr/sbin/chpasswd

# Allow sudo access
$sudo echo "%sudo ALL=(ALL) ALL" >> /etc/sudoers

# User groups and password
$sudo useradd -m -g "$user_name" -s /bin/zsh "$user_name"
echo "$user_name:$user_pass" | $sudo /usr/sbin/chpasswd

# Add user_name to group sudo
$sudo usermod -a -G sudo "$user_name"

# Virtualbox guest
$install_cmd virtualbox-guest-modules-arch

# Section: Clean-Up {{{1
# Proper owner for all of user's home directory
$sudo chown -R "$user_name:users" "/home/$user_name"
