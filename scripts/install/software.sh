#!/bin/bash

# Name: software.sh
# Description: install and update software
# This file is called in the software-update.service

BASE=false

install_cmd="pacman -S --noconfirm"

while test $# -gt 0; do
  case "$1" in
    -b|--base)
      shift
      BASE=true
      ;;
    *)
      break
      ;;
  esac
done

# Grub
$install_cmd grub                   # Grub boot loader

# xSession
$install_cmd xorg                   # Xorg display manager
$install_cmd xorg-xinit             # Xorg xinit
$install_cmd i3-wm                  # i3 window manager
$install_cmd i3blocks               # i3 blocks
$install_cmd i3status               # i3 status bar

# Terminal tools
$install_cmd bluez                  # Bluetooth protocol stack
$install_cmd bluez-utils            # Bluetooth bluetoothctl utility
$install_cmd cronie                 # Cronjob task manager
$install_cmd curl                   # Server exchange requests/responses
$install_cmd curlftpfs              # Mount for FTP
$install_cmd tty-font-awesome       # Font awesome
$install_cmd fuse                   # Mount for ntfs
$install_cmd git                    # Git
$install_cmd gzip                   # Gzip
$install_cmd lm_sensors             # Linux monitoring sensors
$install_cmd networkmanager         # NetworkManager service
$install_cmd ntfs-3g                # Mount for ntfs
$install_cmd openssh                # SSH
$install_cmd rsync                  # Rsync
$install_cmd samba                  # Mount Windows network shares
$install_cmd sshfs                  # Mount SSH
$install_cmd sudo                   # Sudo
$install_cmd tmux                   # Tmux
$install_cmd vim                    # Vim
$install_cmd wget                   # Server download requests
$install_cmd zip                    # Zip
$install_cmd zsh                    # Zsh

# xSession tools
$install_cmd arandr                 # Display configuration
$install_cmd cbatticon              # Tray icon
$install_cmd dmenu                  # Application launcher
$install_cmd firefox                # Firefox
$install_cmd gnome-icon-theme-full  # Icon pack
$install_cmd network-manager-applet # Tray icon
$install_cmd scrot                  # Screen shot
$install_cmd terminator             # Terminal
$install_cmd thunar                 # File browser
$install_cmd xautolock              # Screen autolock

# Software not installed during base install
if ! $BASE; then
  # Terminal tools
  $install_cmd alsa-utils           # Advanced linux sound architecture
  $install_cmd apache               # Web server
  $install_cmd colordiff            # Display diff using git colors
  $install_cmd fdupes               # Duplicate file search
  $install_cmd mariadb              # MySQL database
  $install_cmd pandoc               # General markup converter
  $install_cmd php                  # PHP
  $install_cmd php-apache           # PHP Apache
  $install_cmd phpmyadmin           # PHP based database management
  $install_cmd python               # Python
  $install_cmd ruby                 # Ruby

  # xSession tools
  $install_cmd baobab               # Disk usage
  $install_cmd conky                # Interactive background display
  $install_cmd deluge               # Torrent
  $install_cmd gource               # Fun tool for git repositories
  $install_cmd libreoffice          # LibreOffice
  $install_cmd remmina              # Remote connection interface
  $install_cmd retext               # Markdown editor / viewer
  $install_cmd synergy              # Network mouse/keyboard share
  $install_cmd virtualbox           # Virtualbox
  $install_cmd virtualbox-guest-modules-arch
fi

# Force update for all installed pacages
pacman -Syyu
