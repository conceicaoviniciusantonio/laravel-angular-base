#!/bin/bash
set -e

# Bootstrap .env on first run
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Overwrite DB settings with values from docker-compose environment
sed -i "s|^DB_CONNECTION=.*|DB_CONNECTION=${DB_CONNECTION:-mysql}|" .env
sed -i "s|^# DB_HOST=.*|DB_HOST=${DB_HOST:-db}|" .env
sed -i "s|^# DB_PORT=.*|DB_PORT=${DB_PORT:-3306}|" .env
sed -i "s|^# DB_DATABASE=.*|DB_DATABASE=${DB_DATABASE:-laravel_angular_base}|" .env
sed -i "s|^# DB_USERNAME=.*|DB_USERNAME=${DB_USERNAME:-app_user}|" .env
sed -i "s|^# DB_PASSWORD=.*|DB_PASSWORD=${DB_PASSWORD:-secret}|" .env

composer install --no-interaction --prefer-dist

grep -q '^APP_KEY=.' .env || php artisan key:generate --ansi

php artisan migrate --force

exec php artisan serve --host=0.0.0.0 --port=8000
