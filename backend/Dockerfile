FROM php:8.4-cli-alpine

RUN apk add --no-cache \
    bash \
    git \
    curl \
    unzip \
    libzip-dev \
    oniguruma-dev \
    libxml2-dev \
    icu-dev

RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mbstring \
    xml \
    bcmath \
    zip \
    pcntl \
    intl

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/backend

EXPOSE 8000

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
