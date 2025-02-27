#!/bin/sh
# Start the fake HTTP server in the background
python3 server.py &

# Pipe the acceptance confirmation to Honeygain in case it waits for interactive input
printf "%s\n" "-tou-accept" | honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME"
