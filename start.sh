#!/bin/sh
# Start the fake HTTP server in the background to satisfy Render's requirement.
python3 server.py &

# pull
honeygain/honeygain


# Start Honeygain as per the official Docker instructions.
honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME"
