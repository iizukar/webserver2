#!/bin/sh
# Use proxychains to run the Honeygain client so that outbound traffic goes through the external proxy

# (Optional) Check your current outbound IP via proxychains for debugging:
# proxychains4 curl --silent https://api.ipify.org

# Run initial Honeygain command via proxychains (if required)
proxychains4 ./honeygain -tou-get

# Run Honeygain with terms accepted and account credentials via proxychains.
proxychains4 ./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start a simple HTTP server on port 8000 (for Render health checks)
python3 -m http.server 8000 --bind 0.0.0.0 &

# Keep the container alive
tail -f /dev/null
