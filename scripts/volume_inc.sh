#!/bin/bash

# Increment the volume by 5%
pactl set-sink-volume @DEFAULT_SINK@ +5%

# Get the current volume (front-left percentage)
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '[ /%]+' '{print $4}')

# Check if the volume exceeds 100%
if [ "$VOLUME" -gt 100 ]; then
  # Reset the volume to 100%
  pactl set-sink-volume @DEFAULT_SINK@ 100%
fi
