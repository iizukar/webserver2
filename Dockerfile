FROM honeygain/honeygain

# Install Python for the HTTP health check server
RUN apt-get update && apt-get install -y python3

# Copy the health-check script
WORKDIR /app
COPY health-check.py .

# Start Honeygain and the HTTP server
CMD sh -c "honeygain -tou-accept -email $EMAIL -pass $PASSWORD -device $DEVICE_NAME & python3 /app/health-check.py"
