FROM busybox:latest
	
RUN \
    mkdir -p /var/lib/mysql && \
    adduser -H -D mysql mysql && \
    chown mysql:mysql -R /var/lib/mysql
	
VOLUME /var/lib/mysql

CMD /bin/sh
