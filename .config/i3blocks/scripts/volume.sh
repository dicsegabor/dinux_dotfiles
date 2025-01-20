#!/bin/bash

# Get the volume of the default sink
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '[ /%]+' '{print $4}')

# Get mute status
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Display volume with mute status
if [ "$MUTED" = "yes" ]; then
  echo "Muted"
else
  echo "V: ${VOLUME}%"
fi

case $BLOCK_BUTTON in
1) # Left click: Show the IP
  pavucontrol
  ;;
esac
