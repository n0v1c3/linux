#!/bin/bash

# Display blurred screen-shot as lock screen

# Take current screen-shot
scrot /tmp/screenshot.png

# Blur screen-shot
convert /tmp/screenshot.png -blur 0x10 /tmp/screenshotblur.png

# Lock screen and display blurred screen-shot
i3lock -u -i /tmp/screenshotblur.png

