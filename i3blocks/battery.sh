#!/bin/bash

# Get battery percentage using acpi
BAT=$(acpi -b | grep -E -o '[0-9]+%' | tr -d '%')
REM=$(acpi -b | grep -E -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]' | cut -c-5)

# Check if BAT is valid
if [[ -z "$BAT" || ! "$BAT" =~ ^[0-9]+$ ]]; then
  echo "Error: Unable to retrieve battery percentage."
  exit 1
fi

# Check for click events
case $BLOCK_BUTTON in
1) # Left click: Show the IP
  echo "${REM}"
  ;;
*) # Default: Show "IP"
  echo "B: ${BAT}%"
  ;;
esac
