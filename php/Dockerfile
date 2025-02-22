FROM dunglas/frankenphp

RUN install-php-extensions \
    pcntl \
	pdo_mysql \
    mbstring \
	gd \
	intl \
	zip \
	opcache
WORKDIR /app

COPY ./app /app

ENTRYPOINT ["php", "artisan", "octane:frankenphp"]
