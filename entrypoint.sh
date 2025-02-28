#!/bin/sh

# Start cron for proxy updates
service cron start

# Initial proxy list download
/update_proxies.sh

# Main loop
while true; do
    # Get current proxy list
    mapfile -t proxies < <(jq -r '.[] | "\(.ip):\(.port)"' /proxies.json)
    
    for proxy in "${proxies[@]}"; do
        ip=$(echo "$proxy" | cut -d: -f1)
        port=$(echo "$proxy" | cut -d: -f2)
        
        # Update proxychains config
        echo "strict_chain
        proxy_dns
        tcp_read_time_out 15000
        tcp_connect_time_out 8000

        [ProxyList]
        socks5 $ip $port" > /etc/proxychains.conf

        echo "Trying proxy: $ip:$port"
        
        # Start Honeygain in background
        proxychains ./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" > /tmp/honeygain.log 2>&1 &
        HG_PID=$!
        
        # Monitor for errors
        while sleep 10; do
            # Check if process died
            if ! ps -p $HG_PID > /dev/null; then
                echo "Honeygain process died - switching proxy"
                break
            fi
            
            # Check logs for network errors
            if grep -q -E "NETWORK_ERROR|CONNECTION_FAILED|RESIDENTIAL_CHECK_FAILED" /tmp/honeygain.log; then
                echo "Network error detected - switching proxy"
                kill $HG_PID
                break
            fi
            
            # Check if still connected
            if ! grep -q "Traffic status: ONLINE" /tmp/honeygain.log; then
                echo "Connection lost - switching proxy"
                kill $HG_PID
                break
            fi
        done
        
        # Cleanup before next proxy
        wait $HG_PID
        pkill honeygain
        rm -f /tmp/honeygain.log
    done
done
