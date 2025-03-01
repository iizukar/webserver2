#!/bin/bash

./honeygain -tou-get 
./honeygain -tou-accept -email "$ACCOUNT_EMAIL" -pass "$ACCOUNT_PASSWORD" -device "$DEVICE_NAME" 
