#!/bin/bash

# Fetch proxies and write to JSON
curl -sL "https://raw.githubusercontent.com/r00tee/Proxy-List/main/Socks5.txt" | \
    grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}:[0-9]{1,5}' | \
    jq -R -n '[inputs | split(":") | {ip: .[0], port: .[1]}]' > /proxies.json

# Fallback if empty
[ -s /proxies.json ] || echo '[{"ip":"127.0.0.1","port":"1080"}]' > /proxies.json

# Log result
echo "Updated proxy list with $(jq length /proxies.json) entries"
