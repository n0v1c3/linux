#!/bin/sh

curl -s "https://www.archlinux.org/mirrorlist/?country=US&country=CA&protocol=http&use_mirror_status=on" \
  | sed -e 's/^#Server/Server/' -e '/^#/d' \
  | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist
