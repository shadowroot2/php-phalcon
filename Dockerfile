FROM php:7.4-fpm

MAINTAINER Dmitriy Trigub <dm.trigub@gmail.com>

ARG PSR_VERSION=1.1.0
ARG PHALCON_VERSION=4.1.2
ARG PHALCON_EXT_PATH=php7/64bits

# Установка композера
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Устанавливаем пакеты apt
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        libzip-dev \
        zip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
    	libpng-dev \
    	libmcrypt-dev

# PECL
RUN pecl install mcrypt-1.0.3

# PHP EXT
RUN docker-php-ext-enable mcrypt && \
    docker-php-ext-install zip && \
    docker-php-ext-install mysqli &&  \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd && \
    docker-php-ext-install sockets && \
    docker-php-ext-install calendar

# Устанавливаем Phalcon
RUN set -xe && \
        # Download PSR, see https://github.com/jbboehr/php-psr
        curl -LO https://github.com/jbboehr/php-psr/archive/v${PSR_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PSR_VERSION}.tar.gz && \
        # Download Phalcon
        curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
        tar xzf ${PWD}/v${PHALCON_VERSION}.tar.gz && \
        docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/cphalcon-${PHALCON_VERSION}/build/${PHALCON_EXT_PATH} \
        && \
        # Remove all temp files
        rm -r \
            ${PWD}/v${PSR_VERSION}.tar.gz \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/v${PHALCON_VERSION}.tar.gz \
            ${PWD}/cphalcon-${PHALCON_VERSION} \
        && \
        php -m
