#!/bin/bash

# Define a notification ID
NOTIFICATION_ID=9998

# Get battery information from upower
UP_BATTERY_INFO=$(upower -i "$(upower -e | grep BAT)")

BATTERY_PERCENT=$(echo "$UP_BATTERY_INFO" | grep "percentage" | awk '{print $2}' | tr -d '%')
CHARGING_STATUS=$(echo "$UP_BATTERY_INFO" | grep "state" | awk '{print $2}')
BATTERY_TIME=$(echo "$UP_BATTERY_INFO" | grep -E "time to full|time to empty" | awk '{print $4, $5}')

if [ "$CHARGING_STATUS" = "charging" ]; then
  ICON="" # Battery with lightning
elif [ "$BATTERY_PERCENT" -le 25 ]; then
  ICON="" # Empty battery
elif [ "$BATTERY_PERCENT" -le 50 ]; then
  ICON="" # Quarter battery
elif [ "$BATTERY_PERCENT" -le 75 ]; then
  ICON="" # Half battery
elif [ "$BATTERY_PERCENT" -lt 100 ]; then
  ICON="" # 3 quarters battery
else
  ICON="" # Full battery
fi

# Pad the volume percentage to always be 3 characters
BATTERY_PERCENT_PADDED=$(printf "%3d" "$BATTERY_PERCENT")

# Output the icon and battery percentage (without % symbol)
echo "$ICON  $BATTERY_PERCENT_PADDED"

# Handle click events
case $BLOCK_BUTTON in
3) # Left click: Show runtime or charging time with percentage
  if [ "$CHARGING_STATUS" = "charging" ]; then
    notify-send -r "$NOTIFICATION_ID" "Battery Info" "Charging: $BATTERY_PERCENT% - Time to full charge: ${BATTERY_TIME:-Unknown}"
  else
    notify-send -r "$NOTIFICATION_ID" "Battery Info" "Discharging: $BATTERY_PERCENT% - Runtime remaining: ${BATTERY_TIME:-Unknown}"
  fi
  ;;
1) # Right click: Toggle performance mode
  CURRENT_PROFILE=$(powerprofilesctl get)
  if [ "$CURRENT_PROFILE" = "performance" ]; then
    powerprofilesctl set balanced
    notify-send -r "$NOTIFICATION_ID" "Power Mode" "Switched to Balanced Mode"
  else
    powerprofilesctl set performance
    notify-send -r "$NOTIFICATION_ID" "Power Mode" "Switched to Performance Mode"
  fi
  ;;
esac
