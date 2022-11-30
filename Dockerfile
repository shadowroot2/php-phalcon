FROM php:7.4-fpm
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN apt-get update && apt-get install -y \
		mc \
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

