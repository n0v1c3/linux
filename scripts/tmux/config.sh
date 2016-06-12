#!/bin/bash

# Backup existing tmux.conf dotfile file
cp ~/.tmux.conf ~/.tmux.conf-backup-$(date +%y%m%d-%H%M%S-%N)

# Copy custom tmux.conf dotfile over any existing tmux.conf currently in use
cp $LINUX_DIR/home/.tmux.conf ~/.tmux.conf
