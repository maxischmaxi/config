#!/bin/bash

# MacBook Display = 1
MACBOOK=1

# Alle Fenster holen
WINDOW_IDS=$(yabai -m query --windows | jq '.[].id')

for wid in $WINDOW_IDS; do
  # Falls Fenster schon auf MacBook, nur in neuen Space schieben
  yabai -m window "$wid" --display $MACBOOK
  yabai -m space --create
  yabai -m window "$wid" --space last
done
