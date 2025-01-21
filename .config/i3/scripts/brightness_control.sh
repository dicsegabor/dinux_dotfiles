#!/bin/bash

# Define a notification ID
NOTIFICATION_ID=9995

# Get the current brightness value
get_brightness() {
  xbacklight -get | awk '{print int($1+0.5)}'
}

# Check input parameter
if [ -z "$1" ]; then
  echo "Usage: $0 [+5%|-5%]"
  exit 1
fi

# Handle brightness adjustment
case "$1" in
+* | -*)
  # Adjust brightness
  xbacklight "$1"

  # Get updated brightness percentage
  BRIGHTNESS=$(get_brightness)

  # Choose an icon based on brightness level
  if [ "$BRIGHTNESS" -eq 0 ]; then
    ICON=" " # Brightness off
  elif [ "$BRIGHTNESS" -le 33 ]; then
    ICON=" " # Low brightness
  elif [ "$BRIGHTNESS" -le 66 ]; then
    ICON=" " # Medium brightness
  else
    ICON=" " # High brightness
  fi

  notify-send -r "$NOTIFICATION_ID" "Brightness Control" "$ICON  $BRIGHTNESS%"
  ;;
*)
  echo "Invalid parameter: $1"
  exit 1
  ;;
esac
