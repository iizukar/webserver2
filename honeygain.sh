#!/bin/bash

# Start Honeygain
/app/honeygain \
    --email $HG_EMAIL \
    --password $HG_PASSWORD \
    --device $HG_DEVICE_NAME \
    --disable-activity &
    
# Keep container running
tail -f /dev/null
