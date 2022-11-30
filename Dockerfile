FROM sasys/phalcon74:v1.0.4-fpm

MAINTAINER Dmitriy Trigub <dm.trigub@gmail.com>

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN php -m