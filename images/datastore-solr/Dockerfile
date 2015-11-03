FROM busybox:latest

ENV SOLR_VERSION 4.10.4
ENV SOLR solr-$SOLR_VERSION

RUN mkdir -p /opt/solr

ADD data/ /opt/solr

VOLUME /opt/solr

CMD /bin/sh