#!/usr/bin/env bash

# Live grep + fuzzy match + open with rifle (searches HOME only)
# Dependencies: ripgrep (rg), fzf, rifle

SELECTED=$(rg --no-heading --line-number --color=never . "$HOME" 2>/dev/null |
  fzf --ansi --height=40% --reverse --prompt="🔍 Search and open: ")

if [[ -n "$SELECTED" ]]; then
  FILE=$(echo "$SELECTED" | cut -d':' -f1)
  rifle "$FILE"
fi
