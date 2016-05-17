#!/bin/bash

# Directory variables
configDir=~/.config/xfce4						# Local xfce config dir
backupDir=~/Documents/arch-linux/xfce/config	# Custom xfce config dir

# Backup panels
cat $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml > $backupDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# Backup launchers (required by panels)
cp -r $configDir/panel $backupDir

# Backup keyboard-shortcuts
cat $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml > $backupDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

# Backup desktop configuration
cat $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml > $backupDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
