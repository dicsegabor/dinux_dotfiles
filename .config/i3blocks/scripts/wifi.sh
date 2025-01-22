#!/bin/bash

# Define a notification ID
NOTIFICATION_ID=9997

# Get WiFi information using nmcli
WIFI_INFO=$(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi | grep "^yes:")

if [ -z "$WIFI_INFO" ]; then
  # No active connection
  echo "睊"
  exit 0
fi

# Parse WiFi details
SSID=$(echo "$WIFI_INFO" | awk -F':' '{print $2}')
SIGNAL=$(echo "$WIFI_INFO" | awk -F':' '{print $3}')
IP_ADDRESS=$(nmcli -t -f IP4.ADDRESS dev show | grep -m1 "IP4.ADDRESS" | cut -d':' -f2)

# Determine the icon based on signal strength
# TODO: replace icons later, now only full
if [ "$SIGNAL" -ge 0 ]; then
  ICON="" # Full WiFi
elif [ "$SIGNAL" -ge 50 ]; then
  ICON="奔" # Medium WiFi
elif [ "$SIGNAL" -ge 25 ]; then
  ICON="直" # Weak WiFi
else
  ICON="睊" # No or very poor WiFi
fi

# Output the icon and SSID (if connected)
echo "$ICON  $SIGNAL"

# Handle click events
case $BLOCK_BUTTON in
1) # Left click: Open nmtui
  i3-msg 'exec alacritty --title mixer_floating -e nmtui'
  ;;
3) # Right click: Show signal strength and IP address
  notify-send -r "$NOTIFICATION_ID" -t 20000 "WiFi Info" "SSID: $SSID\nSignal Strength: $SIGNAL%\nIP Address: $IP_ADDRESS"
  ;;
esac
