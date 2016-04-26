FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

RUN \
	apt-get update && \
	apt-get install -y samba && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 137 138 139 445

CMD ["/usr/sbin/smbd", "-FSD", "-d1"]
