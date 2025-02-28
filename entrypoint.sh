#!/bin/bash

# Start cron service
service cron start

# Initial proxy list download
/update_proxies.sh

# Main loop
while true; do
    # Read proxies without mapfile
    proxies=()
    while IFS= read -r line; do
        proxies+=("$line")
    done < <(jq -r '.[] | "\(.ip):\(.port)"' /proxies.json)
    
    for proxy in "${proxies[@]}"; do
        ip=$(echo "$proxy" | cut -d: -f1)
        port=$(echo "$proxy" | cut -d: -f2)
        
        echo "strict_chain
        proxy_dns
        tcp_read_time_out 15000
        tcp_connect_time_out 8000

        [ProxyList]
        socks5 $ip $port" > /etc/proxychains.conf

        echo "Trying proxy: $ip:$port"
        
        # Start Honeygain with timeout
        timeout 60s proxychains ./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" > /tmp/honeygain.log 2>&1
        
        # Check for errors
        if grep -q -E "NETWORK_ERROR|CONNECTION_FAILED|RESIDENTIAL_CHECK_FAILED" /tmp/honeygain.log; then
            echo "Network error detected - switching proxy"
        else
            # If working, keep using this proxy
            while sleep 30; do
                if ! pgrep honeygain > /dev/null; then
                    echo "Process died - restarting proxy cycle"
                    break
                fi
            done
        fi
        
        # Cleanup
        pkill honeygain || true
        rm -f /tmp/honeygain.log
    done
done
