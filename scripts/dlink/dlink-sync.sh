#!/bin/bash

# TODO-TJG [171028] - Add clean-up commands to remove the crap from Documents
rsync -avz -e ssh --info=progress2 --delete ~/Documents/ tjg-dlink:/ffp/home/"$(whoami)"/"$(hostname)"/Documents
