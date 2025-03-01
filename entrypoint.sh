#!/bin/sh

# Start dummy HTTP server in the background
python3 -m http.server 8000 --directory /dummy &

# Login to Bitping with MFA
/app/bitpingd login \
  --email "$BITPING_EMAIL" \
  --password "$BITPING_PASSWORD" \
  --mfa "$BITPING_MFA"

# Start main Bitpingd process
exec /app/bitpingd "$@"
