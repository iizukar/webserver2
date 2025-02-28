FROM honeygain/honeygain

USER root

# Install Python + Dependencies
RUN apt-get update && apt-get install -y python3 wget unzip

# Download and install Localtonet
RUN wget https://localtonet.com/download/localtonet-linux-x64.zip -O localtonet.zip && \
    unzip localtonet.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/localtonet && \
    rm localtonet.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
