#!/bin/bash

# Define a notification ID
NOTIFICATION_ID=9999

# Check input parameter
if [ -z "$1" ]; then
  echo "Usage: $0 [+5%|-5%|toggle]"
  exit 1
fi

# Function to generate volume bar
generate_volume_bar() {
  local VOLUME=$1
  local BAR_LENGTH=30
  local FILLED=$((VOLUME * BAR_LENGTH / 100))
  local EMPTY=$((BAR_LENGTH - FILLED))

  # Only print filled if FILLED > 0
  [ "$FILLED" -gt 0 ] && printf '%s' "$(printf '█%.0s' $(seq 1 $FILLED))"
  # Only print empty if EMPTY > 0
  [ "$EMPTY" -gt 0 ] && printf '%s' "$(printf '░%.0s' $(seq 1 $EMPTY))"
}

# Handle mute and volume adjustment
case "$1" in
toggle)
  # Toggle mute status
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')" = "yes" ]; then
    notify-send -r "$NOTIFICATION_ID" "Volume Control" "  Muted"
  else
    VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '[ /%]+' '/Volume:/ {print $4}')
    BAR=$(generate_volume_bar "$VOLUME")
    notify-send -r "$NOTIFICATION_ID" "Volume Control" "  $BAR"
  fi
  ;;
+* | -*)
  # Unmute if muted
  if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')" = "yes" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ 0
  fi

  # Adjust volume
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
    ICON=" " # Muted (even though not really muted here)
  elif [ "$VOLUME" -le 33 ]; then
    ICON=" " # Low volume
  else
    ICON=" " # High volume
  fi

  BAR=$(generate_volume_bar "$VOLUME")
  notify-send -r "$NOTIFICATION_ID" "Volume Control" "$(printf '%s %s' "$ICON" "$BAR")"
  ;;
*)
  echo "Invalid parameter: $1"
  exit 1
  ;;
esac
