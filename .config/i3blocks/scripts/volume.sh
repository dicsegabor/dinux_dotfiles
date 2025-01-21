#!/bin/bash

# Get the volume of the default sink
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '[ /%]+' '/Volume:/ {print $4}')

# Get mute status
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Determine the icon based on volume level or mute status
if [ "$MUTED" = "yes" ]; then
  ICON=" " # Muted icon
else
  if [ "$VOLUME" -eq 0 ]; then
    ICON=" " # Low volume (0%)
  elif [ "$VOLUME" -le 33 ]; then
    ICON=" " # Medium volume (1-33%)
  else
    ICON=" " # High volume (34-100%)
  fi
fi

# Output the icon and volume percentage
echo "$ICON"

# Handle click events
case $BLOCK_BUTTON in
1) # Left click: Open pavucontrol
  pavucontrol
  ;;
esac
