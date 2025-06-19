#!/bin/sh
set -e

PASS="${IODINED_PASS:-changeme}"
TUN_IP="${IODINED_TUNNEL_IP:-10.0.0.1}"
DOMAIN="${IODINED_DOMAIN:-tunnel.example.com}"

echo "Launching iodined..."
echo "  - Tunnel IP: $TUN_IP"
echo "  - Domain:    $DOMAIN"

exec iodined -f -c -P "$PASS" "$TUN_IP" "$DOMAIN"
