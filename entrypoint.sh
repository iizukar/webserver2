#!/bin/sh
# Use proxychains to run the Honeygain client so that outbound traffic goes through your external PHP proxy

# (Optional) Check current outbound IP using proxychains:
# proxychains curl --silent https://api.ipify.org

# Run initial Honeygain command via proxychains (if needed)
proxychains ./honeygain -tou-get

# Run Honeygain with terms accepted and account credentials via proxychains
proxychains ./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start a dummy HTTP server on port 8000 (for Render health checks)
python3 -m http.server 8000 --bind 0.0.0.0 &

# Keep the container alive
tail -f /dev/null
