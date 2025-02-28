#!/bin/sh

# Fetch latest proxy list with retries
for i in 1 2 3; do
    if curl -sL "https://raw.githubusercontent.com/r00tee/Proxy-List/main/Socks5.txt" -o /tmp/proxies.txt; then
        break
    fi
    sleep 10
done

# Create temporary config
echo "dynamic_chain
proxy_dns
tcp_read_time_out 15000
tcp_connect_time_out 8000

[ProxyList]" > /etc/proxychains.conf.tmp

# Process and test proxies with timeout
valid_proxies=0
while IFS= read -r line; do
    ip_port=$(echo "$line" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}:[0-9]{1,5}')
    [ -z "$ip_port" ] && continue

    ip=$(echo "$ip_port" | cut -d: -f1)
    port=$(echo "$ip_port" | cut -d: -f2)
    
    echo "Testing $ip:$port..."
    if timeout 15s curl --socks5-hostname "$ip:$port" --max-time 10 -s http://ipinfo.io/ip >/dev/null; then
        echo "socks5 $ip $port" >> /etc/proxychains.conf.tmp
        echo "Added working proxy: $ip:$port"
        valid_proxies=$((valid_proxies+1))
        
        # Limit to 50 working proxies to avoid huge configs
        [ $valid_proxies -ge 50 ] && break
    fi
done < /tmp/proxies.txt

# Replace config if valid
if [ $valid_proxies -ge 1 ]; then
    mv /etc/proxychains.conf.tmp /etc/proxychains.conf
    echo "Proxy list updated with $valid_proxies working proxies"
else
    echo "No valid proxies found - keeping previous configuration"
    rm /etc/proxychains.conf.tmp
fi
