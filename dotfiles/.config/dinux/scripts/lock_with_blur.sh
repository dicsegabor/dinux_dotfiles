#!/bin/bash

# Location for temp background
tmpbg="/tmp/i3lock_blur.png"

# Take screenshot with maim and blur it
maim "$tmpbg"
magick "$tmpbg" -blur 0x10 "$tmpbg"

# Run i3lock with supported options
i3lock --nofork \
  -i "$tmpbg" \
  --ignore-empty-password \
  --show-failed-attempts
