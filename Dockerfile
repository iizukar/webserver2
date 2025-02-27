FROM honeygain/honeygain:latest

# Switch to root to install required packages (Python3 and expect)
USER root
RUN apt-get update && apt-get install -y python3 expect

WORKDIR /app

# Copy our scripts into the container
COPY server.py /app/server.py
COPY start.sh /app/start.sh
COPY accept_terms.exp /app/accept_terms.exp

# Ensure the scripts are executable
RUN chmod +x start.sh accept_terms.exp

EXPOSE 8000

CMD ["./start.sh"]
