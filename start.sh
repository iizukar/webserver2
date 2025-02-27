#!/bin/sh
# Start the fake HTTP server in the background
python3 server.py &

# Run the Expect script to launch Honeygain and handle interactive prompt
expect accept_terms.exp
