#!/usr/bin/env bash

# Get current pane dimensions
width=$(tmux display -p "#{pane_width}")
height=$(tmux display -p "#{pane_height}")
adjusted_height=$(echo "$height * 2" | bc)  # height and width are measured in characters, not pixels

# Compare and split accordingly
if [ "$adjusted_height" -gt "$width" ]; then
  tmux split-window -v  # Tall → split horizontally
else
  tmux split-window -h  # Wide → split vertically
fi
