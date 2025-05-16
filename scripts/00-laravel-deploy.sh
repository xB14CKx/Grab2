#!/usr/bin/env bash

echo "Running composer install (no dev dependencies)..."
composer install --no-dev --working-dir=/var/www/html

echo "Clearing caches..."
php artisan config:clear
php artisan route:clear
php artisan view:clear

echo "Caching config, routes, and views..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Creating storage symlink..."
php artisan storage:link

echo "Running migrations fresh with seed..."
php artisan migrate:fresh --seed --force

echo "Deployment script finished."
