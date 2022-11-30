FROM php:7.4-fpm
RUN apt-get update && apt-get install -y \
		mc \
		libpng-dev \
        autoconf \
        zlib1g-dev \
    && pecl channel-update pecl.php.net \
    && pecl install \
       psr \
       phalcon \
    && apt-get remove  \
       autoconf \
       zlib1g-dev \
    && apt-get autoremove
WORKDIR /var/www/html

EXPOSE 80

