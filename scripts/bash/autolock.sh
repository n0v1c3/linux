#!/bin/bash

# Display blurred screen-shot as lock screen

# Take current screen-shot
scrot -z /tmp/screenshot.png

# Blur screen-shot
convert /tmp/screenshot.png -blur 0x10 /tmp/screenshotblur.png

# Remove un-blurred screen-shot
rm /tmp/screenshot.png

# Lock screen and display blurred screen-shot
i3lock -u -i /tmp/screenshotblur.png
