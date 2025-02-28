#!/bin/sh

# Start Tor service
tor -f /etc/tor/torrc &

# Wait for Tor to initialize (15-30 seconds)
echo "Waiting for Tor to start..."
sleep 30

# Verify Tor connection (optional)
curl --socks5-hostname localhost:9050 -s https://check.torproject.org/ | grep -q "Congratulations"
if [ $? -eq 0 ]; then
    echo "Tor connection successful!"
else
    echo "Tor connection failed!"
    exit 1
fi

# Start Honeygain through Tor
torsocks ./honeygain -tou-get
torsocks ./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start dummy HTTP server
python3 -m http.server 8000 --bind 0.0.0.0 &

# Keep container alive
tail -f /dev/null
