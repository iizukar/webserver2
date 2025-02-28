#!/bin/sh

# Scrape proxies and update configuration
python3 /scrape_proxies.py

# Add scraped proxies to proxychains config
if [ -f "/proxies.txt" ]; then
    echo "[ProxyList]" >> /etc/proxychains.conf
    while IFS= read -r line; do
        ip=$(echo "$line" | cut -d: -f1)
        port=$(echo "$line" | cut -d: -f2)
        echo "http $ip $port" >> /etc/proxychains.conf
    done < /proxies.txt
fi

# Start Honeygain through proxychains
proxychains ./honeygain -tou-get
proxychains ./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" &

# Start dummy HTTP server on port 8000
python3 -m http.server 8000 --bind 0.0.0.0 &

# Keep the container alive
tail -f /dev/null
