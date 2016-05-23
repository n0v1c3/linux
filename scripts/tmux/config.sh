#!/bin/bash

# Backup existing conf file
cp ~/.tmux.conf ~/.tmux.conf-backup

# Copy custom conf over any existing conf
cp ~/Documents/linux/config/tmux.conf ~/.tmux.conf
