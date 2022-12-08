FROM dmtrigub/phal4fpm:x64

MAINTAINER Dmitriy Trigub <dm.trigub@gmail.com>

# Устанавливаем пакеты apt
RUN apt-get update && \
    apt-get install -y mc

# PECL
RUN pecl install igbinary && \
    pecl install protobuf && \
    pecl install grpc

# PHP EXT
RUN docker-php-ext-enable igbinary && \
    docker-php-ext-enable protobuf && \
    docker-php-ext-enable grpc

RUN php -m
