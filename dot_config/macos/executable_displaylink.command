#!/bin/bash
# DisplayLink Manager Launcher
# Launches DisplayLink without triggering the macOS screen recording purple icon
# Reference: https://niclake.me/mac-displaylink/

set -euo pipefail

# Path to DisplayLink UserAgent
DISPLAYLINK_PATH="/Applications/DisplayLink Manager.app/Contents/MacOS/DisplayLinkUserAgent"

# Check if DisplayLink Manager is installed
if [[ ! -f "$DISPLAYLINK_PATH" ]]; then
    echo "Error: DisplayLink Manager not found at: $DISPLAYLINK_PATH" >&2
    echo "Please install DisplayLink Manager first." >&2
    exit 1
fi

# Check if DisplayLink is already running
if pgrep -f "DisplayLinkUserAgent" > /dev/null 2>&1; then
    echo "DisplayLink is already running. Skipping launch." >&2
    exit 0
fi

# Launch DisplayLink using screen to avoid the purple screen recording icon
# The 'screen' command is whitelisted by macOS and doesn't trigger the indicator
screen -dmS displaylink arch -arm64 "$DISPLAYLINK_PATH"
echo "DisplayLink launched successfully via screen session." >&2

# Only kill Terminal if this script was launched from Terminal
# This prevents killing Terminal when script is run from login items
if [[ "${TERM_PROGRAM:-}" == "Apple_Terminal" ]]; then
    killall Terminal 2>/dev/null || true
fi

exit 0
