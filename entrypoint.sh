#!/bin/sh
# Fetch Terms of Use (non-interactive)
honeygain -tou-get
# Accept Terms of Use and start Honeygain
honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME"
