#!/bin/sh
PORT=${PORT:-8000}

# Forward Honeygain's port 19321 via Serveo SSH tunnel
ssh -o StrictHostKeyChecking=no -N -R 0:localhost:19321 serveo.net 2>&1 | grep "Forwarding" &

# Start Honeygain
./honeygain -tou-get
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Dummy server for Render
python3 -m http.server $PORT --bind 0.0.0.0 &

tail -f /dev/null
