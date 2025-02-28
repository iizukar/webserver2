FROM honeygain/honeygain

# Switch to root to avoid permission issues
USER root

# Copy and set executable permissions for the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Install a tiny HTTP server (to bind to a port)
RUN apt-get update && apt-get install -y python3
EXPOSE 8000  # Dummy port for Render

# Start Honeygain and the HTTP server
ENTRYPOINT ["/entrypoint.sh"]
