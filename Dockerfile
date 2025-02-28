FROM honeygain/honeygain

# Switch to root to avoid permission issues
USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip proxychains curl

# Install Python libraries for scraping
RUN pip3 install requests beautifulsoup4

# Copy configuration and scripts
COPY entrypoint.sh /entrypoint.sh
COPY scrape_proxies.py /scrape_proxies.py
COPY proxychains.conf /etc/proxychains.conf

# Set permissions
RUN chmod +x /entrypoint.sh

# Explicitly expose port 8000 (required by Render)
EXPOSE 8000

# Entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
