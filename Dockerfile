FROM phpdockerio/php:8.3-fpm
WORKDIR "/var/www/web"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install PHP extensions from package manager
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    php8.3-mysql php8.3-bcmath php8.3-bz2 php8.3-gd php8.3-gmp php8.3-imap php8.3-intl php8.3-ldap php8.3-tidy \
    php8.3-xsl php8.3-curl php8.3-common php8.3-dev php8.3-mbstring php8.3-zip php8.3-xml \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN apt-get update && apt-get -y install cron

# Setup cronjobs
COPY mwcron /etc/cron.d/mwcron
RUN chmod 0644 /etc/cron.d/mwcron
RUN crontab /etc/cron.d/mwcron
# Run cronjobs together with PHP-FPM
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
