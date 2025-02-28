#!/bin/sh
PORT=${PORT:-8000}

# Start Localtonet tunnel for Honeygain's port (replace YOUR_FREE_KEY)
localtonet -key YOUR_LOCALTONET_KEY -tcp 19321 &

# Start Honeygain
./honeygain -tou-get
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Dummy HTTP server for Render
python3 -m http.server $PORT --bind 0.0.0.0 &

# Keep alive
tail -f /dev/null
