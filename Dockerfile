# Use the Honeygain image as the base
FROM honeygain/honeygain

# (Optional) Set default environment variables; these can be overridden on Render
ENV ACCOUNT_EMAIL=your_email@example.com
ENV ACCOUNT_PASSWORD=your_password
ENV DEVICE_NAME=your_device_name

# Install Python3 for the fake web server (if not already installed)
RUN apt-get update && apt-get install -y python3

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port 80 (Render expects a process to listen on a port)
EXPOSE 80

# Set the entrypoint to our script
ENTRYPOINT ["/entrypoint.sh"]
