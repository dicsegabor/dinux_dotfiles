#!/usr/bin/env bash

# Fuzzy-find and open a file using ranger's rifle

# Set search directory (can be changed, e.g., ~/Downloads)
SEARCH_DIR="$HOME"

# Use find to list files, pipe into fzf
SELECTED_FILE=$(find "$SEARCH_DIR" -type f 2>/dev/null | fzf --height=40% --reverse --prompt="Open file: ")

# If a file was selected, open it using rifle
if [[ -n "$SELECTED_FILE" ]]; then
  rifle "$SELECTED_FILE"
fi
