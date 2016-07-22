#!/bin/bash

# TODO (160721) - I believe this file is un-used since a single installer for multiple versions

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
