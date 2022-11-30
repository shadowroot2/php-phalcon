FROM php:7.4-fpm

MAINTAINER Dmitriy Trigub <dm.trigub@gmail.com>

ENV LD_LIBRARY_PATH=/usr/local/lib
ARG PSR_VERSION=1.1.0
ARG PHALCON_VERSION=4.1.2
ARG PHALCON_EXT_PATH=php7/64bits

# COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN set -xe  \
    && apt-get update  \
    && apt-get install -y \
    mc \
    libpng-dev \
    autoconf \
    zlib1g \
    zlib1g-dev
RUN pecl channel-update pecl.php.net \
    && pecl install psr-$PSR_VERSION \
#    && pecl install phalcon-$PHALCON_VERSION
RUN docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
    ${PWD}/php-psr-${PSR_VERSION} \
#   ${PWD}/cphalcon-${PHALCON_VERSION}/build/${PHALCON_EXT_PATH}
# Remove all temp files
RUN rm -r \
    ${PWD}/v${PSR_VERSION}.tar.gz \
    ${PWD}/php-psr-${PSR_VERSION} \
#    ${PWD}/v${PHALCON_VERSION}.tar.gz \
#    ${PWD}/cphalcon-${PHALCON_VERSION} \
# Show modules
RUN php -m