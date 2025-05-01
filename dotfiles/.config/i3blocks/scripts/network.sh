#!/bin/bash

# Define a notification ID
NOTIFICATION_ID=9997
NOTIFICATION_TEXT=""

# Check if Ethernet is connected
ETH_CONNECTED=$(nmcli -t -f DEVICE,TYPE,STATE dev | grep "ethernet:connected" | awk -F':' '{print $1}')

if [ -n "$ETH_CONNECTED" ]; then
  # Ethernet connection is active
  ICON=" "
  IP_ADDRESS=$(nmcli -t -f IP4.ADDRESS dev show "$ETH_CONNECTED" | grep -m1 "IP4.ADDRESS" | cut -d':' -f2)
  NOTIFICATION_TEXT="Ethernet connected\nIP Address: $IP_ADDRESS"
elif WIFI_INFO=$(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi | grep "^yes:"); then
  # WiFi connection is active
  ICON=" "
  SSID=$(echo "$WIFI_INFO" | awk -F':' '{print $2}')
  SIGNAL=$(echo "$WIFI_INFO" | awk -F':' '{print $3}')
  IP_ADDRESS=$(nmcli -t -f IP4.ADDRESS dev show | grep -m1 "IP4.ADDRESS" | cut -d':' -f2)
  NOTIFICATION_TEXT="WiFi connected\nSSID: $SSID\nSignal Strength: $SIGNAL%\nIP Address: $IP_ADDRESS"
else
  # No active connection
  ICON=" "
  NOTIFICATION_TEXT="No active network connection"
fi

# Output the icon
echo " $ICON "

# Handle click events
case $BLOCK_BUTTON in
1) # Left click: Open nmtui
  i3-msg 'exec alacritty --title nm_floating -e nmtui'
  ;;
3) # Right click: Show notification
  notify-send -r "$NOTIFICATION_ID" -t 20000 "Network Info" "$NOTIFICATION_TEXT"
  ;;
esac
