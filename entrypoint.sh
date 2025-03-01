#!/bin/bash

# Start cron service
service cron start

# Start HTTP server in background
python3 -m http.server 8000 --bind 0.0.0.0 > /tmp/http.log 2>&1 &

# Initialize Honeygain
echo "Initializing Honeygain..."
./honeygain -tou-get > /dev/null 2>&1
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" > /tmp/hg-init.log 2>&1

# Main proxy rotation loop
while true; do
    # Get fresh proxies
    mapfile -t proxies < <(grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}:[0-9]{1,5}' /proxies.txt 2>/dev/null)
    
    for proxy in "${proxies[@]}"; do
        ip=$(echo "$proxy" | cut -d: -f1)
        port=$(echo "$proxy" | cut -d: -f2)
        
        # Update proxychains config
        echo "strict_chain
        proxy_dns
        tcp_read_time_out 5000
        tcp_connect_time_out 5000
        
        [ProxyList]
        socks5 $ip $port" > /etc/proxychains.conf

        echo "Attempting proxy: $ip:$port"
        
        # Start Honeygain in foreground
        timeout 60s proxychains ./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" >> /tmp/hg.log 2>&1
        
        # Check if process stayed running
        if ! grep -q "Connection closed" /tmp/hg.log; then
            echo "Proxy working - maintaining connection"
            # Keep alive until failure
            while sleep 30; do
                if ! pgrep -x honeygain > /dev/null; then
                    echo "Connection lost, rotating proxy..."
                    break
                fi
            done
        fi
    done
done
