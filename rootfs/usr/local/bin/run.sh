#!/bin/sh -x

# Set cron period
sed -i "s/<CRON_PERIOD>/$CRON_PERIOD/g" /services/cron/run
FPM_UID=$(id -u $FPM_USER)
FPM_GID=$(id -g $FPM_USER)
sed -i "s/FPM_USER/$FPM_USER/g" /etc/php7/php-fpm.conf
sed -i "s/FPM_UID/$FPM_UID/g" /etc/php7/php-fpm.conf
sed -i "s/FPM_GID/$FPM_GID/g" /etc/php7/php-fpm.conf
sed -i "s/FPM_UID/$FPM_UID/g" /services/cron/run
sed -i "s/FPM_GID/$FPM_GID/g" /services/cron/run

# Selfoss custom configuration file
sed -i "s/lkjl1289/`cat \/dev\/urandom | tr -dc 'a-zA-Z' | fold -w 20 | head -n 1`/g" /selfoss/defaults.ini
sed -i 's/logger_destination=.*/logger_destination=error_log/' /selfoss/defaults.ini
rm -f /selfoss/config.ini

if [ -e /selfoss/data/config.ini ]; then
  cp /selfoss/data/config.ini /selfoss/config.ini
else
  cp /selfoss/defaults.ini /selfoss/data/config.ini
  cp /selfoss/defaults.ini /selfoss/config.ini
fi

# Init data dir
if [ ! "$(ls -Ad /selfoss/data/*/)" ]; then
   cd /selfoss/data/ && mkdir cache favicons logs sqlite thumbnails
fi

# Set permissions
chown -R $UID:$GID /services /var/log /var/lib/nginx

chown -R $FPM_UID:$FPM_GID /selfoss /selfoss/data

# RUN !
exec su-exec $UID:$GID /bin/s6-svscan /services
