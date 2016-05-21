#!/bin/bash

# Directory variables
configDir=/mnt/root/.config/xfce4
backupDir=/mnt/root/Documents/linux/config/xfce

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

# Create local backup of keyboard shortcuts
cp $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml.backup

# Remove existing keyboard shortcuts configuration
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

# Copy desired keyboard-shortcus configuration
cp $backupDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

# Remove existing temporary panel configuration backups
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml.backup

# Backup current panel configuration
cp $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml.backup

# Remove existing panel configuration
rm $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

# Copy desired panel configuration
cp $backupDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml $configDir/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
