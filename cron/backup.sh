#!/bin/bash

# Name: backup.sh
# Description:

sudo mount /mnt/tjg/mine && sudo rsync -a --stats --delete /home /mnt/tjg/mine/back/"$(hostname)"

exit 0
