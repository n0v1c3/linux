#!/bin/bash

# File Backup
BACKUP_ROOT="/"
MEDIA_ROOT="/media/travis/Home - Backup/travis/"
USBWD_ROOT="usbWD"

# usbWD
rsync --dry-run --delete -az $BACKUP_ROOT $MEDIA_ROOT&$USBWD_ROOT
