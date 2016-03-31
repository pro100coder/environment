FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get update && \
    apt-get install -y apt-transport-https curl && \
    curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && \
    echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list && \
    apt-get update && \
    apt-get install -y varnish && \
    echo "admin:admin" > /etc/varnish/secret && \
    apt-get purge -y curl apt-transport-https && \
    apt-get clean -y && apt-get autoclean -y && \
    apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

EXPOSE 6081 6082

ENTRYPOINT ["varnishd"]
CMD ["-F", "-a", ":6081", "-T", ":6082", "-f", "/etc/varnish/default.vcl", "-S", "/etc/varnish/secret", "-s", "malloc,64m"]