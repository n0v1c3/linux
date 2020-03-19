#!/bin/bash

sudo qemu-system-x86_64 \
  -m 4096 \
  -enable-kvm \
  -usb \
  -device usb-host,vendorid=0x064f,productid=0x2af9 \
  -drive file=/home/travis/qemu/accutune.qcow2,format=qcow2 \
  -display sdl \
  -sdl

# Script complete
exit 0
