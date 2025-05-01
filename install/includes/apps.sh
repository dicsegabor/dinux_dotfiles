#!/usr/bin/env bash

# -----------------------------------------------------
# Run selected scripts from the apps/ folder using gum
# -----------------------------------------------------

# Print title
figlet "Configure applications"

# Set target folder
apps_dir="install/apps"
cd "$apps_dir" || {
  echo "apps/ folder not found!"
  exit 1
}

# Get list of files
scripts=(*)
if [ ${#scripts[@]} -eq 0 ]; then
  echo "No files found in $apps_dir"
  exit 1
fi

# Multi-select with gum
selected=$(gum choose --no-limit "${scripts[@]}")
if [ -z "$selected" ]; then
  echo "No scripts selected."
  exit 0
fi

# Run each selected script
for script in $selected; do
  echo -e "\n▶ Running: $script"
  if bash "$script"; then
    echo "✔ $script completed successfully"
  else
    echo "✖ $script failed"
  fi
done
