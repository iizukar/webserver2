FROM honeygain/honeygain

# Switch to root to avoid permission issues
USER root

# Install python3 and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Install proxy.py via pip
RUN pip3 install proxy.py

# Copy and set executable permissions for your entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Explicitly expose port 8000 (for your dummy HTTP server) and port 8888 (for the proxy)
EXPOSE 8000
EXPOSE 8888

# Entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
