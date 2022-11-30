FROM php:7.4-fpm

MAINTAINER Dmitriy Trigub <dm.trigub@gmail.com>

ARG PSR_VERSION=1.1.0
ARG PHALCON_VERSION=4.1.2
ARG PHALCON_EXT_PATH=php7/64bits

COPY --from=composer /usr/bin/composer /usr/bin/composer
