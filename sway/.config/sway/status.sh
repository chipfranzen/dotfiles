#!/bin/bash

get_combined_battery_percent() {
  local bat0_now bat1_now bat0_full bat1_full total_now total_full total_pct

  bat0_now=$(cat /sys/class/power_supply/BAT0/energy_now 2>/dev/null || echo 0)
  bat1_now=$(cat /sys/class/power_supply/BAT1/energy_now 2>/dev/null || echo 0)
  bat0_full=$(cat /sys/class/power_supply/BAT0/energy_full 2>/dev/null || echo 0)
  bat1_full=$(cat /sys/class/power_supply/BAT1/energy_full 2>/dev/null || echo 0)

  total_now=$((bat0_now + bat1_now))
  total_full=$((bat0_full + bat1_full))

  if [ "$total_full" -gt 0 ]; then
    total_pct=$((100 * total_now / total_full))
    echo "${total_pct}"
  else
    echo "?"
  fi
}

while true; do
  time=$(date '+%H:%M:%S')
  battery=$(get_combined_battery_percent)
  sink_info=$(pactl list sinks | grep -A15 'State: RUNNING' || pactl list sinks | grep -A15 'Name:')
  muted=$(echo "$sink_info" | grep Mute | awk '{print $2}')
  volume=$(echo "$sink_info" | grep 'Volume:' | head -n1 | grep -o '[0-9]\+%' | head -n1)

  if [ "$muted" = "yes" ]; then
    volume_display=" muted"
  else
    volume_display=" $volume"
  fi

  echo " $battery%   $volume_display   $time"
  sleep 1
done
