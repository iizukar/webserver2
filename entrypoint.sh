#!/bin/sh
# Use Render's injected PORT variable, default to 8000 if not set
PORT=${PORT:-8000}

# Start Honeygain (ensure variables are set in Render's environment)
./honeygain -tou-get
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start HTTP server on the assigned port
python3 -m http.server $PORT --bind 0.0.0.0 &

# Keep the container running
tail -f /dev/null
