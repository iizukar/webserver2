#!/bin/sh
# Start the fake HTTP server in the background
python3 server.py &

# Pipe the acceptance confirmation to Honeygain in case it waits for interactive input
honeygain -tou-accept -email tamakagi.deitan@gmail.com -pass ryota20020219 -device tamakagi
