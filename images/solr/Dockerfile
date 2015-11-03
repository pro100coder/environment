FROM java:jre

ENV SOLR_VERSION 4.10.4
ENV SOLR solr-$SOLR_VERSION
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN \
    curl -SL http://ftp.byfly.by/pub/apache.org/lucene/solr/$SOLR_VERSION/$SOLR.tgz | tar -xzC /opt && \
    ln -s /opt/$SOLR/example/multicore /opt/solr

ENV SOLR_HOME /opt/$SOLR/example

EXPOSE 8983
WORKDIR /opt/$SOLR/example
ENTRYPOINT [ "java", "-Xmx1024m", "-DSTOP.PORT=8079", "-DSTOP.KEY=stopkey", "-Dsolr.solr.home=multicore", "-jar", "start.jar" ]
