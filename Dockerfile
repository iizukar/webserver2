# Use the official Honeygain image
FROM honeygain/honeygain:latest

# Install Python3 if not already present
RUN apt-get update && apt-get install -y python3

# Copy the fake server and startup script into the container
COPY server.py /app/server.py
COPY start.sh /app/start.sh

# Set working directory
WORKDIR /app

# Ensure the startup script is executable
RUN chmod +x start.sh

# Expose the port that Render will assign (the actual number is provided at runtime via the PORT env variable)
EXPOSE 8000

# Start the container using the startup script
CMD ["./start.sh"]
