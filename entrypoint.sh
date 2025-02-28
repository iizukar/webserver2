#!/bin/sh
# Start Honeygain
./honeygain -tou-get
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start a minimal HTTP server to satisfy Render's port check
python3 -m http.server 8000 &

# Keep the container alive
tail -f /dev/null
