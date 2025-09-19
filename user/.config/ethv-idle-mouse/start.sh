#!/bin/bash

if ! [ -x "$(command -v xprintidle)" ]; then
  sudo apt install xprintidle
fi
if ! [ -x "$(command -v xdotool)" ]; then
  sudo apt install xdotool
fi

# --- Configuration ---
IDLE_TIME_MS=$((1 * 1000)) # 1 sec in milliseconds (adjust as needed)
CHECK_INTERVAL_SECONDS=10       # Check every 5 seconds

# Get screen dimensions
# If you have multiple monitors, this might need adjustment to select the primary
# or the one you want the mouse to center on.
SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d'x' -f1)
SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d'x' -f2)
CENTER_X=$((SCREEN_WIDTH / 2))
CENTER_Y=$((SCREEN_HEIGHT / 2))

while true; do
    CURRENT_IDLE_MS=$(xprintidle)

    if [ "$CURRENT_IDLE_MS" -gt "$IDLE_TIME_MS" ]; then
        xdotool mousemove "$CENTER_X" "$CENTER_Y"
    fi

    sleep "$CHECK_INTERVAL_SECONDS"
done

