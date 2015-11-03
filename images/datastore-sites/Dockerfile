FROM busybox:latest
	
RUN \
	mkdir -p /srv/www/drupal && \
	mkdir -p /srv/www/symfony && \
	mkdir -p /srv/www/sites-enabled && \
	mkdir -p /etc/nginx && \
	chown www-data:www-data -R /srv/www && \
	chmod 775 -R /srv/www

VOLUME /srv/www

CMD /bin/sh
