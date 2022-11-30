FROM php:7.4-fpm
RUN apt-get update && apt-get install -y \
		mc \
        conposer \
		libpng-dev \
        autoconf \
        zlib1g-dev \
    && pecl channel-update pecl.php.net \
    && pecl install \
       psr \
       phalcon-4.1.2 \
    && apt-get remove  \
       autoconf \
       zlib1g-dev \
    && apt-get autoremove

