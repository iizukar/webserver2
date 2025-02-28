#!/bin/sh
PORT=${PORT:-8000}

# Start Localtonet tunnel (replace YOUR_TOKEN)
localtonet -token $LOCALTONET_TOKEN -tcp 19321 &

# Start Honeygain
./honeygain -tou-get
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Dummy HTTP server
python3 -m http.server $PORT --bind 0.0.0.0 &

# Keep container alive
tail -f /dev/null
