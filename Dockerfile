FROM php:7.4

ARG PSR_VERSION=1.1.0
ARG PHALCON_VERSION=4.1.2
ARG PHALCON_EXT_PATH=php7/64bits

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
    apt-get install -y php-memcached \
    set -xe && \
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

COPY docker-phalcon-* /usr/local/bin/