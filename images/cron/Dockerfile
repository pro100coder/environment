FROM pro100coder/enviroment:ssh

# Install
RUN \
    apt-get update && \
    apt-get purge -y openssh-server mc && apt-get autoremove -y && \
    apt-get install -y cron && \
    apt-get -y autoclean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

RUN \
    touch /etc/cron.d/custom && \
    chmod 0644 /etc/cron.d/custom

VOLUME /etc/cron.d

# Run the command on container startup
ENTRYPOINT []
CMD ["cron", "-f"]

