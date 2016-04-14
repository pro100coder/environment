FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

# User settings
RUN \
    usermod -m -d /srv/www -s /bin/bash www-data && \
    echo "www-data:www-data" | chpasswd && \
    mkdir /var/run/sshd && \
    mkdir -p /srv/www && \
    chown -R www-data:www-data /srv/www

# Install curl and nodejs repo
RUN \
    apt-get update && apt-get install -y curl  && \
    curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm bower less && \
    apt-get -y autoclean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Install RVM
RUN \
    curl -sSL https://rvm.io/mpapis.asc | gpg --import - && \
    curl -sSL https://get.rvm.io | bash -s stable --rails && \
    /bin/bash -l -c "gem install bundler sass compass" && \
    usermod -aG rvm www-data

# Install
RUN \
    apt-get update && \
    apt-get install -y  \
      postgresql-client \
      mariadb-client    \
      openssh-server    \
      bash-completion   \
      nano              \
      mc                \
      git               \
      wget              \
      php5-dev \
      php-pear \
      autoconf \
      automake \
      libcurl3-openssl-dev \
      build-essential \
      libxslt1-dev \
      re2c \
      libxml2 \
      libxml2-dev \
      php5-cli \
      bison \
      libbz2-dev \
      libreadline-dev \
      libfreetype6 \
      libfreetype6-dev \
      libpng12-0 \
      libpng12-dev \
      libjpeg-dev \
      # libjpeg8-dev \
      # libjpeg8  \
      libgd-dev \
      libgd3 \
      libxpm4 \
      libltdl7 \
      libltdl-dev \
      libssl-dev \
      openssl \
      gettext \
      libgettextpo-dev \
      libgettextpo0 \
      libicu-dev \
      libmhash-dev \
      libmhash2 \
      libmcrypt-dev \
      libmcrypt4 && \
    apt-get clean -y && apt-get autoclean -y && \
    apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Install PhpBrew
RUN \
    curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew && \
    chmod +x phpbrew && \
    mv phpbrew /usr/local/bin/phpbrew && \
    chown www-data:www-data /usr/local/bin/phpbrew && \
    su -l www-data -c "phpbrew init" && \
    su -l www-data -c "echo 'source ~/.phpbrew/bashrc' >> ~/.bashrc" && \
    su -l www-data -c "phpbrew install -j $(nproc) 7.0 +default +intl" && \
    su -l www-data -c "phpbrew switch 7.0.5"

# Install composer
RUN \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chown www-data:www-data /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

# Install drush
RUN \
    wget http://files.drush.org/drush.phar && \
    php drush.phar core-status && \
    chmod +x drush.phar && \
    mv drush.phar /usr/local/bin/drush && \
    chown www-data:www-data /usr/local/bin/drush

# Setting php-cli for symfony
RUN echo date.timezone = Europe/Minsk >> /etc/php5/cli/php.ini

# Problem http://goo.gl/UcMZ9a
RUN echo 'KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1' >> /etc/ssh/sshd_config

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd"]
CMD ["-D"]
