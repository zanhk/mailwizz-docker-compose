#!/bin/bash

# Start cron in the background
service cron start

# Start PHP-FPM in the foreground
exec /usr/sbin/php-fpm8.3 -O
