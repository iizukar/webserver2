#!/bin/sh
PORT=${PORT:-8000}

# Authenticate Ngrok (replace $NGROK_AUTH_TOKEN with your token)
ngrok config add-authtoken $NGROK_AUTH_TOKEN

# Tunnel Honeygain's critical port (19321) via Ngrok TCP
ngrok tcp 19321 --log=stdout > /dev/null &

# Start Honeygain
./honeygain -tou-get
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start dummy HTTP server for Render
python3 -m http.server $PORT --bind 0.0.0.0 &

# Keep the container alive
tail -f /dev/null
