FROM php:7.4-fpm

MAINTAINER Dmitriy Trigub <dm.trigub@gmail.com>

ARG PSR_VERSION=1.1.0
ARG PHALCON_VERSION=4.1.2

RUN set -xe && \
    # Download PSR, see https://github.com/jbboehr/php-psr
    curl -LO https://github.com/jbboehr/php-psr/archive/v${PSR_VERSION}.tar.gz && \
    tar xzf /v${PSR_VERSION}.tar.gz && \
    # Download Phalcon
    curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
    tar xzf /v${PHALCON_VERSION}.tar.gz && \
    docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
        /php-psr-${PSR_VERSION} \
        /cphalcon-${PHALCON_VERSION}/build/phalcon \
    && \
    # Remove all temp files
    rm -r \
        /v${PSR_VERSION}.tar.gz \
        /php-psr-${PSR_VERSION} \
        /v${PHALCON_VERSION}.tar.gz \
        /cphalcon-${PHALCON_VERSION} \
    && \
    php -m \

COPY --from=composer /usr/bin/composer /usr/bin/composer