#!/bin/bash

# Get memory usage percentage
MEM=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

# Check if MEM is valid
if [[ -z "$MEM" || ! "$MEM" =~ ^[0-9]+$ ]]; then
  echo "Error: Unable to retrieve memory usage."
  exit 1
fi

# Check for click events
case $BLOCK_BUTTON in
1) # Left click: Show the IP
  alacritty --command "htop"
  ;;
*) # Default: Show "IP"
  echo "${MEM}%"
  ;;
esac
