#!/bin/bash

# Generate fstab
genfstab -p /mnt >> /mnt/etc/fstab

# Set hostname
echo $1 > /mnt/etc/hostname
