FROM honeygain/honeygain:latest

# Switch to root to install packages
USER root

# Update apt and install Python3
RUN apt-get update && apt-get install -y python3

# Copy the fake server and startup script into the container
COPY server.py /app/server.py
COPY start.sh /app/start.sh

# Set the working directory
WORKDIR /app

# Ensure the startup script is executable
RUN chmod +x start.sh

# Expose the port Render will supply (e.g., 8000 by default)
EXPOSE 8000

# Start the container using the startup script
CMD ["./start.sh"]
