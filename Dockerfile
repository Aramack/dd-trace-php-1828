FROM php:8.1-fpm as build

# Install nginx
RUN apt-get update
RUN apt-get install nginx zip unzip --yes

# Install Datadog PHP Tracer
RUN curl --request GET "https://github.com/DataDog/dd-trace-php/releases/download/0.82.0/datadog-php-tracer_0.82.0_amd64.deb" --verbose --silent --location --output ./datadog-php-tracer_0.82.0_amd64.deb
RUN dpkg --install  ./datadog-php-tracer_0.82.0_amd64.deb

# Install Composer
RUN curl --request GET "https://getcomposer.org/installer" --verbose --silent --location --output ./composer-setup.php
RUN php ./composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Install phpseclib
RUN composer require phpseclib/phpseclib:2.0.21

# Move example scripts
COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/php-fpm.conf /var/www/html
COPY files/index.php /var/www/html

# Move startup script
COPY files/docker-entrypoint.sh ./docker-entrypoint.sh
RUN ["chmod", "+x", "docker-entrypoint.sh"]
CMD ./docker-entrypoint.sh

