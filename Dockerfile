FROM php:7.1-apache

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
