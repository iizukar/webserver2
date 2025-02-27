#!/bin/sh

# Start the fake HTTP server in the background
python3 server.py

# Run Honeygain with your command-line parameters.
# Replace the placeholder environment variables with your actual Render environment variables.
honeygain -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" 

#accept
-tou-accept 


