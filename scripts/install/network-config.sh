#!/bin/bash

# Generate fstab
genfstab -p /mnt >> /mnt/etc/fstab

# Set hostname
echo $1 > /mnt/etc/hostname

# Enable DHCP
arch-chroot /mnt systemctl enable dhcpcd.service
