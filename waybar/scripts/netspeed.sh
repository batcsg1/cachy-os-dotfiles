#!/usr/bin/env bash
# Prints download/upload speed as JSON for waybar

IFACE=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $5; exit}')
[ -z "$IFACE" ] && { echo '{"text":"–","tooltip":"no interface"}'; exit 0; }

STATE_FILE="/tmp/waybar_netspeed_$IFACE"
RX_NOW=$(cat /sys/class/net/"$IFACE"/statistics/rx_bytes)
TX_NOW=$(cat /sys/class/net/"$IFACE"/statistics/tx_bytes)
NOW=$(date +%s)

if [ -f "$STATE_FILE" ]; then
    read -r RX_OLD TX_OLD TIME_OLD < "$STATE_FILE"
    INTERVAL=$((NOW - TIME_OLD))
    [ "$INTERVAL" -lt 1 ] && INTERVAL=1
    RX_RATE=$(( (RX_NOW - RX_OLD) / INTERVAL ))
    TX_RATE=$(( (TX_NOW - TX_OLD) / INTERVAL ))
else
    RX_RATE=0
    TX_RATE=0
fi

echo "$RX_NOW $TX_NOW $NOW" > "$STATE_FILE"

fmt() {
    local bytes=$1
    if [ "$bytes" -ge 1048576 ]; then
        awk -v b="$bytes" 'BEGIN{printf "%.1f MB/s", b/1048576}'
    else
        awk -v b="$bytes" 'BEGIN{printf "%.0f KB/s", b/1024}'
    fi
}

DOWN=$(fmt "$RX_RATE")
UP=$(fmt "$TX_RATE")

echo "{\"text\":\"󰇚 ${DOWN}  󰕒 ${UP}\",\"tooltip\":\"Interface: ${IFACE}\"}"
