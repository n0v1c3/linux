#  Root password
arch-chroot /mnt echo "root:$rootPass" | chpasswd

# Create user
arch-chroot /mnt useradd -m -g users -s /bin/bash $nameUser
arch-chroot /mnt echo "$nameUser:$password" | chpasswd


