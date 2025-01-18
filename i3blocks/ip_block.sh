#!/bin/bash

# Check for click events
case $BLOCK_BUTTON in
1) # Left click: Show the IP
  hostname -i
  ;;
3)
  alacritty --command "nmtui"
  echo "IP"
  ;;
*) # Default: Show "IP"
  echo "IP"
  ;;
esac
