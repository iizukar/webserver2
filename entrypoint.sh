#!/bin/sh
PORT=${PORT:-8000}

# Add Cargo to PATH
export PATH="/root/.cargo/bin:$PATH"

# Start bore tunnel for Honeygain's port
bore local 19321 --port 19321 &

# Start Honeygain
./honeygain -tou-get
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Dummy server for Render
python3 -m http.server $PORT --bind 0.0.0.0 &

tail -f /dev/null
