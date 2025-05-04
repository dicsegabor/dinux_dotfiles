#!/bin/bash

# Try to source notification ID file, if it exists and is readable
if [ -f "$XDG_RUNTIME_DIR/dunst_ids.env" ]; then
  source "$XDG_RUNTIME_DIR/dunst_ids.env"
fi

# Use env variable if set, otherwise generate a random fallback
NOTIFICATION_ID=${DUNST_ID_VOLUME:-$((RANDOM % 100000 + 10000))}

# Check input parameter
if [ -z "$1" ]; then
  echo "Usage: $0 [+5%|-5%|toggle]"
  exit 1
fi

# Function to get current volume as a number
get_volume() {
  pactl get-sink-volume @DEFAULT_SINK@ | awk -F '[ /%]+' '/Volume:/ {print $4}'
}

# Handle mute and volume adjustment
case "$1" in
toggle)
  # Toggle mute
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"; then
    notify-send -r "$NOTIFICATION_ID" "Volume" " Muted"
  else
    VOLUME=$(get_volume)
    notify-send -r "$NOTIFICATION_ID" -h int:value:"$VOLUME" "Volume" " $VOLUME%"
  fi
  ;;
+* | -*)
  # Unmute if currently muted
  if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"; then
    pactl set-sink-mute @DEFAULT_SINK@ 0
  fi

  # Adjust volume
  pactl set-sink-volume @DEFAULT_SINK@ "$1"

  # Get updated volume
  VOLUME=$(get_volume)

  # Cap the volume between 0 and 100
  if [ "$VOLUME" -gt 100 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ 100%
    VOLUME=100
  elif [ "$VOLUME" -lt 0 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ 0%
    VOLUME=0
  fi

  # Choose appropriate icon
  if [ "$VOLUME" -eq 0 ]; then
    ICON=""
  elif [ "$VOLUME" -le 33 ]; then
    ICON=""
  else
    ICON=""
  fi

  notify-send -r "$NOTIFICATION_ID" -h int:value:"$VOLUME" "Volume" "$ICON $VOLUME%"
  ;;
*)
  echo "Invalid parameter: $1"
  exit 1
  ;;
esac
