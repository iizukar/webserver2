#!/bin/sh

# Set proxy environment variables so that honeygain uses the proxy
export http_proxy="http://127.0.0.1:8888"
export https_proxy="http://127.0.0.1:8888"

# Start the proxy server on port 8888 (listening on all interfaces)
proxy --hostname 0.0.0.0 --port 8888 &

# Start Honeygain: get terms of use and accept them with your credentials
./honeygain -tou-get
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start dummy HTTP server on port 8000 (required by Render)
python3 -m http.server 8000 --bind 0.0.0.0 &

# Keep the container alive
tail -f /dev/null
