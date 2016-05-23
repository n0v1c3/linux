#!/bin/bash

# User install

# Root password
echo -n "Enter rootpass: "
read rootpass
arch-chroot /mnt $(echo "root:$rootpass" | chpasswd)

# User account
echo -n "Enter username: "
read username
echo -n "Enter password: "
read password
arch-chroot /mnt useradd -m -g users -s /bin/bash $username
arch-chroot /mnt $(echo "$username:$password" | chpasswd)
