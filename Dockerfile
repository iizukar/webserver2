FROM honeygain/honeygain

# Switch to root to avoid permission issues
USER root

# Install Python3 and proxychains (assuming a Debian/Ubuntu–based image)
RUN apt-get update && apt-get install -y python3 proxychains

# Copy the custom proxychains configuration file into the container
COPY proxychains.conf /etc/proxychains.conf

# Copy entrypoint.sh and set executable permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Explicitly expose port 8000 (required by Render for health checks)
EXPOSE 8000

# Set the entrypoint to our custom script
ENTRYPOINT ["/entrypoint.sh"]
