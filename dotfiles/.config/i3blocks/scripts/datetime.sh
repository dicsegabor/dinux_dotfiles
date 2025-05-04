#!/bin/bash

# Try to source notification ID file, if it exists and is readable
if [ -f "$XDG_RUNTIME_DIR/dunst_ids.env" ]; then
  source "$XDG_RUNTIME_DIR/dunst_ids.env"
fi

# Use env variable if set, otherwise generate a random fallback
NOTIFICATION_ID=${DUNST_ID_DATETIME:-$((RANDOM % 100000 + 10000))}

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
