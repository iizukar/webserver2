#!/bin/sh
# Start Honeygain
./honeygain -tou-get
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start dummy HTTP server on port 8000
python3 -m http.server 8000 --bind 0.0.0.0 &

# Keep the container alive
tail -f /dev/null
