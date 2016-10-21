#!/bin/bash

# This script displays the number of the current space (desktop) in the menu bar
# It assumes that each space has been given a desktop picture in System Preferences,
# and that the name of that picture begins with the number of the space followed by a hyphen.
# Example: /Users/Joe/Pictures/backgrounds/8-tile.tiff for desktop number 8

# Get the file name of the current desktop picture
S=`osascript -e 'tell application "System Events" ' -e ' return (picture of current desktop) as text' -e 'end tell' 2>/dev/null`

# Strip off directory path, i.e. everything before first slash
S=${S##*/}

# Strip off everything after first hyphen
S=${S%%-*}

# Display the space number
echo $S