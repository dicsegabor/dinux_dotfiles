#!/bin/bash

# Define a notification ID
NOTIFICATION_ID=9994

# Fetch the current temperature (optimized for wttr.in)
TEMPERATURE=$(curl -s 'https://wttr.in?format=%t')

# Output the temperature for the status bar
echo "$TEMPERATURE"

# Handle click events
case $BLOCK_BUTTON in
1) # Left click: Show hourly forecast in terminal
  i3-msg 'exec alacritty --title wttr_fullscreen --hold -e curl -Ss "https://wttr.in?hourly"'
  ;;
3) # Right click: Show detailed weather information
  WEATHER_DETAILS=$(curl -s 'https://wttr.in?format=%l\n%C\n%t\n%w\n%h')
  LOCATION=$(echo "$WEATHER_DETAILS" | head -n 1)
  CONDITION=$(echo "$WEATHER_DETAILS" | sed -n '2p')
  TEMPERATURE=$(echo "$WEATHER_DETAILS" | sed -n '3p')
  WIND=$(echo "$WEATHER_DETAILS" | sed -n '4p')
  HUMIDITY=$(echo "$WEATHER_DETAILS" | sed -n '5p')

  notify-send -r "$NOTIFICATION_ID" -t 20000 "Weather report" \
    "<b>Location:</b> $LOCATION\n<b>Condition:</b> $CONDITION\n<b>Temperature:</b> $TEMPERATURE\n<b>Wind:</b> $WIND\n<b>Humidity:</b> $HUMIDITY"
  ;;
esac
