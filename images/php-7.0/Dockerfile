FROM php:7.0-fpm

# Install modules
RUN \
    apt-get update && \
    apt-get install -y libicu-dev \
      libpq-dev \
      libxml2-dev \
      libmcrypt-dev \
      libjpeg62-turbo-dev \
      libpng12-dev \
      libsqlite3-dev \
      libcurl4-openssl-dev \
      libmemcached-dev && \
    apt-get autoremove -y && \
    apt-get clean -y && apt-get autoclean -y && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Install php extensions
RUN \
    docker-php-ext-install -j$(nproc) pdo_sqlite && \
    # docker-php-ext-install dom && \
    docker-php-ext-install -j$(nproc) intl && \
    docker-php-ext-install opcache && \
    # docker-php-ext-install phar && \
    docker-php-ext-install -j$(nproc) pdo_pgsql && \
    # docker-php-ext-install soap && \
    docker-php-ext-install -j$(nproc) simplexml  && \
    docker-php-ext-install curl && \
    docker-php-ext-install iconv && \
    docker-php-ext-install -j$(nproc) mcrypt && \
    docker-php-ext-configure gd --with-jpeg-dir=/tmp/jpeg -with-png-dir=/tmp/png && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install -j$(nproc) mbstring && \
    docker-php-ext-install -j$(nproc) pdo && \
    docker-php-ext-install -j$(nproc) pdo_mysql

# memcached
RUN \
    apt-get update && \
    apt-get install -y git wget && \
    git clone https://github.com/php-memcached-dev/php-memcached.git && \
    cd php-memcached && \
    git checkout php7 && \
    phpize && \
    ./configure --disable-memcached-sasl && \
    make && \
    make install && \
    docker-php-ext-enable memcached && \
    cd .. && rm -rf php-memcached && \
# xdebug
    wget http://xdebug.org/files/xdebug-2.4.0.tgz && \
    tar -xvzf xdebug-2.4.0.tgz && \
    cd xdebug-2.4.0 && \
    phpize && \
    ./configure --enable-xdebug --with-php-config=/usr/local/bin/php-config && \
    make && \
    make install && \
    docker-php-ext-enable xdebug && \
    cd .. && rm -rf xdebug-2.4 && \
# clear
    apt-get purge -y git wget && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    apt-get autoclean -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Install mongodb
RUN \
    pecl install --force mongodb && \
    docker-php-ext-enable mongodb


# Install igbinary
# RUN pecl install --force igbinary && \
#     docker-php-ext-enable memcached


# Configure
ADD data/etc/php/php.ini /usr/local/etc/php/php.ini
#ADD data/etc/php-fpm.conf /usr/local/etc/php-fpm.conf

CMD ["php-fpm"]
