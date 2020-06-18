#!/bin/sh
xrandr --output LVDS1 --mode 1366x768 --pos 1680x0 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output HDMI1 --off --output HDMI2 --off --output HDMI3 --off --output VGA1 --mode 1680x1050 --pos 0x0 --rotate normal --output VIRTUAL1 --off
xdotool keydown Shift Super_L key 2 keyup Shift Super_L
xdotool keydown Super_L key 3 keyup Super_L
xdotool keydown Super_L key d keyup Super_L
xdotool key b r o w s e r Return Return
xdotool keydown Super_L key 2 1 keyup Super_L
xdotool keydown Super_L key Return keyup Super_L
