#!/usr/bin/env bash

# -----------------------------------------------------
# Clone Neovim config into .config/nvim (relative path)
# -----------------------------------------------------

repo_url="https://github.com/dicsegabor/nvim.git"
target_dir="$HOME/dinux/$version/.config/nvim"

# Remove existing config if present
if [ -d "$target_dir" ]; then
  echo "Removing existing config at $target_dir"
  rm -rf "$target_dir"
fi

# Clone the repo (shallow clone for speed)
echo "Cloning Neovim config from $repo_url to $target_dir"
git clone --depth 1 "$repo_url" "$target_dir"

# Confirm success
if [ $? -eq 0 ]; then
  echo "Neovim config cloned successfully."
else
  echo "Failed to clone Neovim config." >&2
  exit 1
fi
