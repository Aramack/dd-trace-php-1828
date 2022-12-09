#!/bin/bash
# Start nginx server
/usr/sbin/nginx -g 'daemon off;'&

# Start PHP-FPM 
/usr/local/sbin/php-fpm --nodaemonize  --fpm-config /var/www/html/php-fpm.conf &

# Wait for any process to exit
wait -n
# Exit with status of process that exited first
exit $?


