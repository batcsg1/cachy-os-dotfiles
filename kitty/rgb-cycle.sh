#!/usr/bin/env bash
# Cycles kitty's cursor, active border and active tab through the spectrum.
# Run from inside kitty (uses $KITTY_LISTEN_ON):  ~/.config/kitty/rgb-cycle.sh &
colors=(ff1744 ff6d00 ffd600 00e676 00e5ff 2979ff d500f9 ff00aa)
delay=${1:-0.4}
i=0
while :; do
  c=${colors[i % ${#colors[@]}]}
  kitten @ set-colors -a \
    cursor="#$c" active_border_color="#$c" active_tab_background="#$c" 2>/dev/null || exit 0
  i=$((i + 1))
  sleep "$delay"
done
