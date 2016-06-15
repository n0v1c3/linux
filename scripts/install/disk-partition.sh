#!/bin/bash

echo -e "Please enter path to disk (/dev/sd[x]): "
read diskpath

# Partition disk
echo -e "o\nn\np\n1\n\n+100M\nn\np\n2\n\n+2G\nn\np\n3\n\n\na\n1\nt\n2\n82\nw\n" | fdisk ${diskPath}

# Swap file system
mkswap ${diskPath}2
swapon ${diskPath}2

# Create ext4 file system
mkfs.ext4 ${diskPath}3

# Mount new file system
mount ${diskPath}3 /mnt
