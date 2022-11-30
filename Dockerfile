FROM php:7.4-fpm
RUN apt-get update && apt-get install -y \
		mc \
        composer \
		libpng-dev \
        autoconf \
        zlib1g-dev \
    && pecl channel-update pecl.php.net \
    && pecl install -y \
       psr \
       phalcon-4.1.2 \
    && apt-get remove -y  \
       autoconf \
       zlib1g-dev \
       libpng-dev \
    && apt-get autoremove -y \
    && echo "extension=psr.so">/etc/php/7.4/mods-available/psr.ini \
    && echo "extension=phalcon.so">/etc/php/7.4/mods-available/phalcon.ini \
	&& ln -s /etc/php/7.4/mods-available/psr.ini /etc/php/7.4/cli/conf.d/10-psr.ini  \
    && ln -s /etc/php/7.4/mods-available/psr.ini /etc/php/7.4/fpm/conf.d/10-psr.ini \
    && ln -s /etc/php/7.4/mods-available/phalcon.ini /etc/php/7.4/cli/conf.d/30-phalcon.ini  \
    && ln -s /etc/php/7.4/mods-available/phalcon.ini /etc/php/7.4/fpm/conf.d/30-phalcon.ini
