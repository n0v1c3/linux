# Load X configuration
xrdb ~/.Xresources
xmodmap ~/.xmodmap

# Disable X system bell
xset b off

# Run the i3-wm
exec i3

# TODO [170401] - What am I using this for?
ssh-agent i3
