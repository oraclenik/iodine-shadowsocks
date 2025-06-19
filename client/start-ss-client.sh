#!/bin/sh
set -e

echo "[+] Waiting for iodine tunnel to be ready..."
sleep 5

echo "[+] Launching ss-local to connect to ${TUNNEL_GATEWAY}:${SS_REMOTE_PORT}"
exec ss-local \
  -s "${TUNNEL_GATEWAY}" \
  -p "${SS_REMOTE_PORT}" \
  -l "${LOCAL_SOCKS_PORT}" \
  -k "${SS_PASSWORD}" \
  -m "${SS_METHOD}" \
  --plugin v2ray-plugin 
