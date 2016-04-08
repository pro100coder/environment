FROM php:5.6-fpm

# Install modules
RUN \
    apt-get update && \
    apt-get install -y \
      g++ \
      libicu-dev \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libmcrypt-dev \
      libpng12-dev \
      libxml2-dev \
      libcurl4-openssl-dev \
      libpq-dev \
      graphviz \
      libmemcached-dev \
      libsqlite3-dev && \
    apt-get clean -y && apt-get autoclean -y && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Install php extensions
RUN \
    docker-php-ext-install -j$(nproc) sockets && \
    docker-php-ext-install -j$(nproc) zip && \
    docker-php-ext-install -j$(nproc) pdo_sqlite && \
    # docker-php-ext-install dom && \
    docker-php-ext-install -j$(nproc) intl && \
    docker-php-ext-install -j$(nproc) opcache && \
    # docker-php-ext-install phar && \
    docker-php-ext-install -j$(nproc) pdo_pgsql && \
    docker-php-ext-install -j$(nproc) soap && \
    docker-php-ext-install -j$(nproc) simplexml  && \
    docker-php-ext-install -j$(nproc) curl && \
    docker-php-ext-install -j$(nproc) iconv && \
    docker-php-ext-install -j$(nproc) mcrypt && \
    docker-php-ext-configure gd --with-jpeg-dir=/tmp/jpeg -with-png-dir=/tmp/png && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install -j$(nproc) mbstring && \
    docker-php-ext-install -j$(nproc) pdo && \
    docker-php-ext-install -j$(nproc) pdo_mysql

# Install pecl extensions
RUN pecl install --force \
      xdebug \
      memcached \
      xhprof \
      mongo &&\
    docker-php-ext-enable xdebug && \
    docker-php-ext-enable memcached && \
    docker-php-ext-enable xhprof && \
    docker-php-ext-enable mongo
