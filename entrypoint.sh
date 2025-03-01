#!/bin/sh

# Start dummy HTTP server in the background
python3 -m http.server 8000 --directory /dummy &

# Login to Bitping using environment variables
/app/bitpingd login --email "$BITPING_EMAIL" --password "$BITPING_PASSWORD"

# Start the main Bitpingd process
exec /app/bitpingd "$@"
