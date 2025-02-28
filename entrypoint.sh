#!/bin/bash

# Start required services
service cron start
python3 -m http.server 8000 --bind 0.0.0.0 > /dev/null 2>&1 &

# Main proxy rotation loop
while true; do
    # Get fresh proxies (format: IP:PORT)
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
        
        # Start Honeygain with short timeout
        timeout 30s proxychains ./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" > /tmp/hg.log 2>&1
        
        # Check for immediate failures
        if grep -q -E "NETWORK_ERROR|UNABLE_TO_CONNECT|RESIDENTIAL_CHECK" /tmp/hg.log; then
            echo "Failed proxy: $ip:$port"
            continue
        else
            # Keep using working proxy until failure
            while true; do
                sleep 15
                if ! pgrep -x honeygain > /dev/null || grep -q -E "NETWORK_ERROR|DISCONNECTED" /tmp/hg.log; then
                    echo "Connection lost, rotating proxy..."
                    pkill -x honeygain
                    break
                fi
            done
        fi
    done
done
