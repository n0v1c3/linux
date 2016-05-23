#!/bin/bash

echo -e "Please enter path to disk (/dev/sd[x]): "
read diskpath

# Partition disk
echo -e "o\nn\np\n1\n\n+100M\nn\np\n2\n\n+2G\nn\np\n3\n\n\na\n1\nt\n2\n82\nw\n" | fdisk ${diskPath}

# Swap file system
mkswap ${diskPath}2	# Make swap file system
swapon ${diskPath}2	# Turn swap file system on

# Create ext4 file system
mkfs.ext4 ${diskPath}3

# Mount new file system
mount ${diskPath}3 /mnt

# Grub - Bootloader
arch-chroot /mnt pacman -S --noconfirm grub			# Install
arch-chroot /mnt grub-install --target=i386-pc ${diskpath}	# Install grub into boot section of /dev/sd(x)
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg		# Set grub configuration
