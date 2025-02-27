#!/bin/sh
# Start the fake HTTP server in the background to satisfy Render's requirement
python3 server.py &

# Use the 'yes' command to continuously send "-tou-accept" so that if an interactive prompt appears, it receives the input.
yes "-tou-accept" | honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME"
