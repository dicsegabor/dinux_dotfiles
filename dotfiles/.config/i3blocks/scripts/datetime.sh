#!/bin/bash

# Define a notification ID for persistent notifications
NOTIFICATION_ID=9993

# Output only the time to i3blocks bar
echo " $(date "+%H:%M:%S") "

# Handle click events
case $BLOCK_BUTTON in
1) # Left click: Open calendar in terminal
  i3-msg 'exec alacritty --title cal_floating -e calcurse'
  ;;
3) # Right click: Show notification
  # Get current date and time details
  DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
  DAY=$(date "+%A")

  # Fetch location dynamically (replace this with a real location API if needed)
  LOCATION=$(curl -s https://ipinfo.io/city || echo "Unknown")
  notify-send -r "$NOTIFICATION_ID" "Date & Time Info" "$DATETIME\n$DAY\n$LOCATION"
  ;;
esac
