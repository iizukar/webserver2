#!/bin/sh
# Step 1: Retrieve the TOU (this can be skipped if already done)
# Use the full path to the honeygain binary
honeygain -tou-get

# Step 2: Accept the TOU with your credentials.
# Running it in the background allows the script to continue.
honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# (Optional) Wait a few seconds to let Honeygain initialize
sleep 5

# Step 3: Start a simple HTTP server on port 80 to keep the container alive.
python3 -m http.server 80
