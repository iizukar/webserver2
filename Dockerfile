FROM honeygain/honeygain

# Switch to root to avoid permission issues
USER root

# Install Python (if the base image uses Debian/Ubuntu)
RUN apt-get update && apt-get install -y python3

# Copy and set executable permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Explicitly expose port 8000 (required by Render)
EXPOSE 8000

# Entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
