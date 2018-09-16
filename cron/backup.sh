#!/bin/bash

# Name: backup.sh
# Description:

dlink=$HOME/Desktop/.mnt/dlink

mkdir --parents $dlink
mount dlink:/ffp $dlink && sudo rsync -a --no-o --no-g --stats --delete $HOME/ $dlink/backups/"$(hostname)"/

exit 0
