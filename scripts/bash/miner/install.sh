#!/bin/bash

# Name: install.sh
# Description: Install Arch Linux with desired software and configurations 

# Variables {{{1
# Pre-Defined {{{2
# Disk partition (100M Boot, 4G Swap, x ext4) {{{3
disk_partition="o\nn\np\n1\n\n+100M\nn\np\n2\n\n+4G\nn\np\n3\n\n\na\n1\nt\n2\n82\nw\n"

# GitHub {{{3
github="https://github.com"

# Sudo {{{3
sudo="arch-chroot /mnt"
sudo_gid=101
install_cmd="$sudo pacman -S --noconfirm --needed"

# Miner {{{3
miner_home="/usr/local/miner"
miner_version="v10.0"
miner_name="Claymore.s.Dual.Ethereum.Decred_Siacoin_Lbry_Pascal.AMD.NVIDIA.GPU.Miner.$miner_version.-.LINUX.tar.gz"
miner_releases="https://github.com/nanopool/Claymore-Dual-Miner/releases/download"
miner_tar="$miner_releases/$miner_version/$miner_name"

# User Input {{{2
# Get installation information
echo "Select device for installation: "
select disk in $(lsblk -ndl --output NAME)
do
    diskpath=/dev/$disk
    break
done

# Computer hostname
echo -n "Hostname: ";       read -r hostname

# Root password
echo -n "Root password: ";  read -r -s root_pass
password="password"
repassword="repassword"
while [ $password != $repassword ]; do
  echo -n "$1"
  read -r -s password
  echo ""

  echo -n "Re-enter $1"
  read -r -s repassword
  echo ""
done
$root_pass = $password

# Username and password
echo -n "Username: ";       read -r user_name
password="password"
repassword="repassword"
while [ $password != $repassword ]; do
  echo -n "Enter user password: "
  read -r -s password
  echo ""

  echo -n "Re-enter user password: "
  read -r -s repassword
  echo ""
done
$user_pass = $password

# Other information
echo -n "User full name: "; read -r user_full
echo -n "User e-mail: ";    read -r user_email
echo ""
echo -n "Git username:";    read -r git_user

user_home="/home/$user_name"
git_home=/home/$user_name/Documents/development/$git_user

# Functions {{{1
# AUR
function pkg
{
    pushd
    cd "/mnt$user_home/Downloads" || exit 1
    wget "https://aur.archlinux.org/cgit/aur.git/snapshot/${1}.tar.gz"
    tar -xvzf "./${1}.tar.gz"
    cd "./${1}" || exit 1
    $sudo chown -R "$user_name":"$user_name" "$user_home/Downloads/"
    $sudo su "$user_name" -c "cd $user_home/Downloads/${1}; makepkg --noconfirm"
    $sudo su -c "cd $user_home/Downloads/${1}; pacman -U --noconfirm -- *.xz"
    cd .. || exit 1
    rm -rf "${1}"
    rm "${1}.tar.gz"
    popd
}

# Disk Formatting {{{1
# Remove existing partitions and re-partition based on $disk_partition string
dd if=/dev/zero of="${diskpath}" bs=1k count=2048
echo -e $disk_partition | fdisk "${diskpath}"

# Swap file system
mkswap "${diskpath}"2
swapon "${diskpath}"2

# Create ext4 file system
mkfs.ext4 "${diskpath}"3

# Mount new file system
mount "${diskpath}"3 /mnt

# Install {{{1
# Mirror ranking {{{2
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# Base {{{2
# Kernel {{{3
pacstrap /mnt base

# Users {{{3
# Sudoers
$sudo groupadd -g $sudo_gid sudo
touch /mnt/etc/sudoers
print "root ALL=(ALL) ALL" > /mnt/etc/sudoers
print "%sudo ALL=(ALL) ALL" >> /mnt/etc/sudoers

# Root password
echo "root:$root_pass" | $sudo /usr/sbin/chpasswd

# User groups and password
$sudo groupadd "$user_name"
$sudo useradd -m -g "$user_name" -s /bin/bash "$user_name"
$sudo usermod -a -G sudo "$user_name"
echo "$user_name:$user_pass" | $sudo /usr/sbin/chpasswd

# Required directories
$sudo su "$user_name" -c "mkdir /home/$user_name/Documents"
$sudo su "$user_name" -c "mkdir /home/$user_name/Downloads"
$sudo su "$user_name" -c "mkdir --parents $git_home"

# Mirrors {{{3
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

# Time {{{3
$sudo ln -s /usr/share/zoneinfo/Canada/Mountain /mnt/etc/localtime

# Locales {{{3
echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > /mnt/etc/locale.gen
$sudo locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf

# Fstab {{{3
#genfstab -p /mnt >> /mnt/etc/fstab

# Networking {{{3
$install_cmd networkmanager # NetworkManager service
$sudo systemctl enable dhcpcd.service
echo "$hostname" > /mnt/etc/hostname

# Software {{{2
# Grub {{{3
$install_cmd grub
$sudo grub-install --target=i386-pc "${diskpath}"
$sudo grub-mkconfig -o /boot/grub/grub.cfg

# SSH {{{3
$install_cmd openssh
$install_cmd sshfs
echo "AllowUsers $user_name" >> /mnt/etc/ssh/sshd_config
$sudo systemctl enable sshd.service

# xSession {{{3
$install_cmd xorg
$install_cmd xorg-xinit
$install_cmd xterm
$install_cmd i3
$install_cmd i3-wm
$install_cmd i3status

# Git {{{3
$install_cmd git
$sudo su travis -c "git config --global user.email \"${user_email}\""
$sudo su travis -c "git config --global user.name \"${user_full}\""
$sudo su travis -c "git clone $github/$git_user/miner.git $git_home/miner"

# Powerline fonts {{{3
$sudo git clone "$github/powerline/fonts.git"
$sudo bash ./fonts/install.sh
$sudo rm -rf fonts

# LM Sensors {{{3
$install_cmd lm_sensors     # Linux monitoring sensors
$sudo sensors-detect --auto

# Terminal tools {{{3
$install_cmd colordiff      # Display diff using git colors
$install_cmd curl           # Server exchange requests/responses
$install_cmd gzip            # Zip
$install_cmd reflector      # Pacman mirror update tool
$install_cmd screen         # Screen virtual terminal
$install_cmd sudo           # Sudo
$install_cmd vim            # Vim
$install_cmd wget           # Server download requests
$install_cmd zsh            # Zsh

# Ethereum-Git {{{3
# Official {{{4
$install_cmd autoconf
$install_cmd automake
$install_cmd binutils
$install_cmd boost
$install_cmd cmake
$install_cmd crypto++
$install_cmd fakeroot
$install_cmd gcc
$install_cmd geth
$install_cmd hiredis
$install_cmd leveldb
$install_cmd libmicrohttpd
$install_cmd make
$install_cmd miniupnpc
$install_cmd ocl-icd
$install_cmd opencl-headers
$install_cmd pkg-config
$install_cmd yajl

# AUR {{{4
pkg argtable
pkg libjson-rpc-cpp-git
pkg ethereum-git

# Drivers {{{2
$install_cmd libcurl-compat # Used for (libcurl.so.3)
$install_cmd nvidia
$install_cmd nvidia-settings
$install_cmd opencl-nvidia
$install_cmd cuda

$sudo nvidia-xconfig --enable-all-gpus --cool-bits=28

# Mining Rig {{{1
# Download and install claymore's miner
$sudo wget --output_document "$user_home/Downloads" "$miner_tar"
$sudo mkdir --parents "$miner_home"
$sudo tar -xvf "$user_home/Downloads/$miner_name" -C "$miner_home"
$sudo rm "$user_home/Downloads/$miner_name"
$sudo chmod u+s "$miner_home/ethdcrminer64"

# Proper owner for all of user's home directory
$sudo chown -R $user_name:users /home/$user_name

# Copy and configure important scripts and services
$sudo cp "$git_home/miner/scripts/miner.sh" "$miner_home/"
$sudo cp "$git_home/miner/scripts/checkup.sh" "$user_home/"
$sudo cp "$git_home/miner/scripts/launcher.sh" "$user_home/"
$sudo cp "$git_home/miner/system/miner.servie" "/etc/systemd/system/"
$sudo chmod o+x "$miner_home/miner.sh"
$sudo chmod o+x "$user_home/checkup.sh"
$sudo chmod o+x "$user_home/launcher.sh"
$sudo systemctl enable miner.service

# Success {{{1
printf "\nInstallation complete!"
sleep 10
sync
umount /mnt
shutdown -h 0 &
exit 0
