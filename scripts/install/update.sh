#!/bin/bash

# Name: linux/scripts/install/update.sh
# Description: Apply system updates and basic maintenance

# Clock synchronization
sudo ntpd

# Display failed systemd services
sudo systemctl --failed --all

# Display high priority systemd errors
sudo journalctl -p 3 -xb

# Update pacman mirrors, see /etc/systemd/system/reflector.service
echo "Update pacman mirrors"
sudo systemctl start reflector

# Force update pacman packages
echo "Update pacman installed packages"
sudo pacman -Syyu

# Update personal git repositories
cd "$(printenv "$n0v1c3")" || exit
git-pull

# Generate list of "bad" files
sudo rmlint --types="badlinks,emptydirs,emptyfiles" -o pretty:stdout /home

# Backup current crontab
crontab -l | tail -n +2 > "$n0v1c3/linux/dotfiles/home/.config/cron/crontab.txt"
