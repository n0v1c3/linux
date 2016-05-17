#!/bin/bash

########################################################################
# Variables
########################################################################

# Directory variables
configDir=~/.config/xfce4
backupDir=~/Documents/arch-linux/xfce/config

########################################################################
# Restore panels
########################################################################

# Shut-down panels
xfce4-panel --quit	# xfce4 panel
pkill xfconfd		# xfce4 configuration daemon

# Remove existing temporary panel configuration backups
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml.backup

# Backup current panel configuration
cp $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml.backup

# Remove existing panel configuration
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# Remove existing launcher configuration
rm -r $configDir/panel/

# Copy desired panel configuration
cp $backupDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# Copy desired panel launchers
cp -r $backupDir/panel $configDir

########################################################################
# Keyboard shrotcuts
########################################################################

# Remove existing temporary keyboard shorcuts configuration backups
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml.backup

# Create local backup of keyboard shortcuts
cp $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml.backup

# Remove existing keyboard shortcuts configuration
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

# Copy desired keyboard-shortcus configuration
cp $backupDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

########################################################################
# Desktop
########################################################################

# Remove existing temporary panel configuration backups
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml.backup

# Backup current panel configuration
cp $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml.backup

# Remove existing panel configuration
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

# Copy desired panel configuration
cp $backupDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

########################################################################
# Restart xfce
########################################################################

# Start panels (in background)
xfce4-panel &
echo "You must restart the X server for all changes to take effect"

