FROM php:7.0-apache

RUN apt-get update && apt-get install -y \
	libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    zlib1g-dev \
    libssl-dev \
    git \
    --no-install-recommends \
    && apt-get clean \
	&& rm -r /var/lib/apt/lists/* \

    && docker-php-ext-install -j$(nproc) pcntl \
	&& docker-php-ext-install -j$(nproc) mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) sockets \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) zip \

    && pecl install xdebug \
    && docker-php-ext-enable xdebug \

    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \

    && a2enmod rewrite \

    && mkdir /app

COPY config/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d

COPY config/000-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /app

# 启动mariadb
# docker run --name my-mariadb -e MYSQL_ROOT_PASSWORD=develop -v /Volumes/Data/Docker/mariadb-data:/var/lib/mysql -p 3306:3306 -d mariadb

# 启动php
# docker run -d -p 80:80 --name rofcloud_mix --mount type=bind,source=/Volumes/Data/Code/rofcloud_mix/,target=/app --link my-mariadb:mysql my-php-dev

# Possible values for ext-name:
# bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv imap interbase intl json ldap mbstring mcrypt mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode reflection session shmop simplexml snmp soap sockets spl standard sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip