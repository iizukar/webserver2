FROM honeygain/honeygain

# Switch to root to have permission for installing packages
USER root

# Install Python3 for the fake web server (if not already installed)
RUN apt-get update && apt-get install -y python3

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port 80 for the web server
EXPOSE 80

# Set the entrypoint to our script
ENTRYPOINT ["/entrypoint.sh"]
