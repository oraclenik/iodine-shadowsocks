#!/bin/sh
set -e

echo "[+] Connecting to iodine server: $TUNNEL_DOMAIN"
exec iodine -f -P "$IODINED_PASS" -r "$IODINED_IP" "$TUNNEL_DOMAIN"
