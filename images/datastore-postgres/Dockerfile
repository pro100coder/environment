FROM busybox:latest
	
RUN \
    mkdir -p /var/lib/postgresql/data && \
    adduser -H -D postgres postgres && \
    chown postgres:postgres -R /var/lib/postgresql/data
	
VOLUME /var/lib/postgresql/data

CMD /bin/sh
