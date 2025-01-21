#!/bin/bash

# Define a notification ID
NOTIFICATION_ID=9999

# Check input parameter
if [ -z "$1" ]; then
  echo "Usage: $0 [+5%|-5%|toggle]"
  exit 1
fi

# Handle mute and volume adjustment
case "$1" in
toggle)
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')" = "yes" ]; then
    notify-send -u low -r "$NOTIFICATION_ID" "Volume Control" "  Muted"
  else
    VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '[ /%]+' '/Volume:/ {print $4}')
    notify-send -u low -r "$NOTIFICATION_ID" "Volume Control" "  $VOLUME%"
  fi
  ;;
+* | -*)
  pactl set-sink-volume @DEFAULT_SINK@ "$1"
  VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '[ /%]+' '/Volume:/ {print $4}')

  # Ensure the volume stays within 0% to 100%
  if [ "$VOLUME" -gt 100 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ 100%
    VOLUME=100
  elif [ "$VOLUME" -lt 0 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ 0%
    VOLUME=0
  fi

  # Choose an icon based on the volume level
  if [ "$VOLUME" -eq 0 ]; then
    ICON=" " # Muted
  elif [ "$VOLUME" -le 33 ]; then
    ICON=" " # Low volume
  else
    ICON=" " # High volume
  fi

  notify-send -u low -r "$NOTIFICATION_ID" "Volume Control" "$ICON $VOLUME%"
  ;;
*)
  echo "Invalid parameter: $1"
  exit 1
  ;;
esac
