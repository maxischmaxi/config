#!/bin/bash

# Displays definieren
WIDESCREEN=2
MACBOOK=1

# Slack auf MacBook (Display 1, Space 2)
SLACK_WIN_ID=$(yabai -m query --windows | jq '.[] | select(.app == "Slack") | .id')
if [ -n "$SLACK_WIN_ID" ]; then
  yabai -m window "$SLACK_WIN_ID" --display $MACBOOK --space 1
fi

# Chrome auf Widescreen (Display 2, Space 1)
CHROME_WIN_ID=$(yabai -m query --windows | jq '.[] | select(.app == "Google Chrome") | .id')
if [ -n "$CHROME_WIN_ID" ]; then
  yabai -m window "$CHROME_WIN_ID" --display $WIDESCREEN --space 1
fi

# Ghostty auf Widescreen (Display 2, Space 1)
GHOSTTY_WIN_ID=$(yabai -m query --windows | jq '.[] | select(.app == "Ghostty") | .id')
if [ -n "$GHOSTTY_WIN_ID" ]; then
  yabai -m window "$GHOSTTY_WIN_ID" --display $WIDESCREEN --space 1
fi

MONGO_COMPASS_WIND_ID=$(yabai -m query --windows | jq '.[] | select(.app == "MongoDB Compass") | .id')
if [ -n "$MONGO_COMPASS_WIND_ID" ]; then
  yabai -m window "$MONGO_COMPASS_WIND_ID" --display $MACBOOK --space 1
fi
