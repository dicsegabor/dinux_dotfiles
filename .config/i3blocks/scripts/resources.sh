#!/bin/bash

# Define a notification ID
NOTIFICATION_ID=9996

# Get memory information
MEM_INFO=$(free -h | grep "Mem:")
TOTAL_MEM=$(echo "$MEM_INFO" | awk '{print $2}')
USED_MEM=$(echo "$MEM_INFO" | awk '{print $3}')
USED_PERCENT=$(awk -v used="$USED_MEM" -v total="$TOTAL_MEM" 'BEGIN {printf "%.0f", (used / total) * 100}')

# Memory icon (single icon as you optimized it)
MEM_ICON=""

# Output only RAM usage for the status bar
echo "$MEM_ICON  $USED_PERCENT"

# Handle click events
case $BLOCK_BUTTON in
1) # Left click: Open htop
  i3-msg 'exec alacritty --title htop_fullscreen -e htop'
  ;;
3) # Right click: Show detailed resource information

  notify-send -r "$NOTIFICATION_ID" "Calculating metrics..."

  # Free memory
  FREE_MEM=$(echo "$MEM_INFO" | awk '{print $4}')

  # Get CPU usage (average of all cores over 1 second)
  CPU_USAGE=$(top -bn2 | grep "Cpu(s)" | tail -n1 | awk '{print $2 + $4}')

  # Get thermal information using `sensors`
  THERMAL_INFO=$(sensors | grep -m1 'Core 0' | awk '{print $3}' | tr -d '+') || THERMAL_INFO="N/A"

  # Display notification
  notify-send -r "$NOTIFICATION_ID" -t 20000 "Resource Monitor" \
    "Memory:\n- Total: $TOTAL_MEM\n- Used: $USED_MEM\n- Free: $FREE_MEM\n- Usage: $USED_PERCENT%\n\nCPU:\n- Usage: $(printf '%.1f' "$CPU_USAGE")%\n\nThermals:\n- Temp: $THERMAL_INFO"
  ;;
esac
