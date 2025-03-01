#!/bin/sh

# Start dummy HTTP server in the background
python3 -m http.server 8000 --directory /dummy &

-it \
  -e BITPING_EMAIL=czechia.deitan@gmail.com \
  -e BITPING_PASSWORD=ryota20020219 \
  --mount type=volume,source="bitpingd-volume",target=/root/.bitpingd bitping/bitpingd:latest

# Start the main Bitpingd process
exec /app/bitpingd "$@"
