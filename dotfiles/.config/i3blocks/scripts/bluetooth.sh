#!/bin/bash

# Try to source notification ID file, if it exists and is readable
if [ -f "$XDG_RUNTIME_DIR/dunst_ids.env" ]; then
  source "$XDG_RUNTIME_DIR/dunst_ids.env"
fi

# Use env variable if set, otherwise generate a random fallback
NOTIFICATION_ID=${DUNST_ID_BLUETOOTH:-$((RANDOM % 100000 + 10000))}

# Get Bluetooth status using bluetoothctl
BT_STATUS=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
CONNECTED_DEVICE=$(bluetoothctl info | grep "Alias:" | awk -F': ' '{print $2}')

# Check if Bluetooth is on
if [ "$BT_STATUS" != "yes" ]; then
  # Bluetooth is off
  ICON="" # Bluetooth icon without background
  STATUS_MESSAGE="Bluetooth is OFF"
else
  # Bluetooth is on
  ICON="" # Bluetooth icon with background
  if [ -z "$CONNECTED_DEVICE" ]; then
    STATUS_MESSAGE="Bluetooth is ON\nNo connected devices"
  else
    STATUS_MESSAGE="Bluetooth is ON\nConnected to: $CONNECTED_DEVICE"
  fi
fi

# Output the icon
echo " $ICON "

# Handle click events
case $BLOCK_BUTTON in
1) # Left click: Open blueman-manager
  i3-msg 'exec blueman-manager'
  ;;
3) # Right click: Show Bluetooth status and connected device info
  notify-send -r "$NOTIFICATION_ID" "Bluetooth Info" "$STATUS_MESSAGE"
  ;;
esac
