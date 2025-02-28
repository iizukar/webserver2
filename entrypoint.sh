#!/bin/sh

# Start cron service
service cron start

# Initial proxy configuration
/update_proxies.sh

# Start Honeygain through proxychains
proxychains ./honeygain -tou-get
proxychains ./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start dummy HTTP server
python3 -m http.server 8000 --bind 0.0.0.0 &

# Keep container alive
tail -f /dev/null
