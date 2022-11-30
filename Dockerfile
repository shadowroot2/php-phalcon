FROM php:7.4-fpm

MAINTAINER Dmitriy Trigub <dm.trigub@gmail.com>

ARG PSR_VERSION=1.1.0
ARG PHALCON_VERSION=4.1.2
ARG PHALCON_EXT_PATH=php7/64bits

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN docker-php-ext-install opcache mbstring pdo_mysql
RUN apt-get update && apt-get install -y \
    mc \
    libpng-dev \
    autoconf \
    zlib1g-dev
RUN pecl channel-update pecl.php.net \
RUN php -m