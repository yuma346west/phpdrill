FROM dunglas/frankenphp as builder

RUN install-php-extensions \
    pcntl \
    pdo_mysql \
    mbstring \
    gd \
    intl \
    zip \
    opcache \
    xdebug

COPY ./conf/php.ini $PHP_INI_DIR/php.ini

WORKDIR /app

COPY ./app/ /app