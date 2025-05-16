FROM richarvey/nginx-php-fpm:3.1.6

COPY . .

# Fix permissions for Laravel storage and cache (necessary for logs, sessions, views)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Image config
ENV SKIP_COMPOSER=1
ENV WEBROOT=/var/www/html/public
ENV PHP_ERRORS_STDERR=1
ENV RUN_SCRIPTS=1
ENV REAL_IP_HEADER=1

# Laravel config
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV LOG_CHANNEL=stderr

# Allow composer to run as root (if you run composer inside container)
ENV COMPOSER_ALLOW_SUPERUSER=1

# Expose port 80 for HTTP traffic
EXPOSE 80

# Optional healthcheck (checks PHP-FPM status)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

CMD ["/start.sh"]
