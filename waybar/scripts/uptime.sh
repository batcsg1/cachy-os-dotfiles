#!/usr/bin/env bash
UPTIME=$(uptime -p | sed 's/^up //')
echo "{\"text\":\"󰥔 ${UPTIME}\",\"tooltip\":\"System uptime\"}"
