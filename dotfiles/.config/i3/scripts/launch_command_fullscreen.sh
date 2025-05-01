#!/bin/bash

# Check if a command is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <command>"
  exit 1
fi

# Extract the base command and append "_fullscreen" to the title
APP_COMMAND="$1"
APP_TITLE="${APP_COMMAND// /_}_fullscreen"

# Launch the application with the modified title and fullscreen
i3-msg "exec alacritty --title $APP_TITLE -e $APP_COMMAND" && sleep 0.1 && i3-msg "[title=\"^${APP_TITLE}$\"] fullscreen"
