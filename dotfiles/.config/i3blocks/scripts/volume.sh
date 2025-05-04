#!/bin/bash

# Try to source notification ID file, if it exists and is readable
if [ -f "$XDG_RUNTIME_DIR/dunst_ids.env" ]; then
  source "$XDG_RUNTIME_DIR/dunst_ids.env"
fi

# Use env variable if set, otherwise generate a random fallback
NOTIFICATION_ID=${DUNST_ID_VOLUME:-$((RANDOM % 100000 + 10000))}

# Function to get current volume
get_volume() {
  pactl get-sink-volume @DEFAULT_SINK@ | awk -F '[ /%]+' '/Volume:/ {print $4}'
}

# Function to get mute status
get_mute_status() {
  pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'
}

# Function to choose icon
get_icon() {
  local vol=$1
  local muted=$2
  if [ "$muted" = "yes" ]; then
    echo ""
  elif [ "$vol" -eq 0 ]; then
    echo ""
  elif [ "$vol" -le 33 ]; then
    echo ""
  else
    echo ""
  fi
}

# If called with argument: adjust volume
if [ -n "$1" ]; then
  case "$1" in
  toggle)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;
  +* | -*)
    if [ "$(get_mute_status)" = "yes" ]; then
      pactl set-sink-mute @DEFAULT_SINK@ 0
    fi
    pactl set-sink-volume @DEFAULT_SINK@ "$1"
    ;;
  *)
    echo "Invalid parameter: $1"
    exit 1
    ;;
  esac

  # After adjustment, show notification
  VOLUME=$(get_volume)
  MUTED=$(get_mute_status)
  ICON=$(get_icon "$VOLUME" "$MUTED")

  if [ "$MUTED" = "yes" ]; then
    notify-send -r "$NOTIFICATION_ID" "Volume" " Muted"
  else
    notify-send -r "$NOTIFICATION_ID" -h int:value:"$VOLUME" "Volume" "$ICON $VOLUME%"
  fi

  exit 0
fi

# If no argument: behave as block (e.g. for i3blocks/polybar)

# Get current state
VOLUME=$(get_volume)
MUTED=$(get_mute_status)
ICON=$(get_icon "$VOLUME" "$MUTED")

# Pad volume
VOLUME_PADDED=$(printf "%3d" "$VOLUME")

# Output for block display
echo "$ICON  $VOLUME_PADDED"

# Handle clicks
case $BLOCK_BUTTON in
1) # Left click
  i3-msg 'exec alacritty --title mixer_floating -e pulsemixer'
  ;;
3) # Right click
  notify-send -r "$NOTIFICATION_ID" "Volume" "$ICON  $VOLUME_PADDED%"
  ;;
esac
