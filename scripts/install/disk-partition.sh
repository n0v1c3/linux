#!/bin/bash

# Partition disk
echo -e "o\nn\np\n1\n\n+100M\nn\np\n2\n\n+2G\nn\np\n3\n\n\na\n1\nt\n2\n82\nw\n" | fdisk ${1}

# Swap file system
mkswap ${1}2
swapon ${1}2

# Create ext4 file system
mkfs.ext4 ${1}3

# Mount new file system
mount ${1}3 /mnt
