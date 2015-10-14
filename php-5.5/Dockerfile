FROM php:5.5-fpm

# Install modules
RUN \
    apt-get update && \
    apt-get install -y g++ libicu-dev libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libxml2-dev libcurl4-openssl-dev libpq-dev graphviz libmemcached-dev libsqlite3-dev && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Install php extensions
RUN \
    docker-php-ext-install pdo_sqlite && \
    docker-php-ext-install dom && \
    docker-php-ext-install intl && \
    docker-php-ext-install opcache && \
    docker-php-ext-install phar && \
    docker-php-ext-install pdo_pgsql && \
    docker-php-ext-install soap && \
    docker-php-ext-install simplexml  && \
    docker-php-ext-install curl && \
    docker-php-ext-install iconv && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-configure gd --with-jpeg-dir=/tmp/jpeg -with-png-dir=/tmp/png && \
    docker-php-ext-install gd && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install pdo && \
    docker-php-ext-install pdo_mysql

# Install pecl extensions
RUN pecl install --force xdebug memcached xhprof-0.9.4

# Configure
ADD data/etc/php/php.ini /usr/local/etc/php/php.ini
ADD data/etc/php-fpm.conf /usr/local/etc/php-fpm.conf

CMD ["php-fpm"]
