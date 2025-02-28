#!/bin/sh
# Fetch Terms of Use (non-interactive)
-tou-get
# Accept Terms of Use and start Honeygain
-tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME"
