# Load X configuration
xrdb ~/.Xresources

setxkbmap -option caps:escape &

# Disable X system bell
xset b off

# Run the i3-wm
exec i3
