FROM tommylau/php-5.2

COPY data/xdebug-2.2.1.tgz /tmp/xdebug-2.2.1.tgz

COPY data/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN \
    tar -xvzf /tmp/xdebug-2.2.1.tgz && \
    cd xdebug-2.2.1 && \
    /usr/local/bin/phpize && \
    ./configure --enable-xdebug --with-php-config=/usr/local/bin/php-config && \
    make && \
    make test && \
    make install && \
    cd ../ && \
    rm -rf xdebug-2.2.1
