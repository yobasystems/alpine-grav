#!/bin/ash

[ -f /run-pre.sh ] && /run-pre.sh

if [ ! -d /usr/html ] ; then
  mkdir -p /usr/html
  chown -R nginx:nginx /usr/html
else
  chown -R nginx:nginx /usr/html
fi

if [ ! -d /usr/html/system ] ; then
  curl -fLk -o /tmp/grav.zip  "https://getgrav.org/download/skeletons/deliver-site/1.2.0"
  mkdir /tmp/grav-src
  unzip /tmp/grav.zip -d /tmp/grav-src
  mv -f /tmp/grav-src/grav-admin/* /usr/html/
  rm -R /tmp/grav*
  chown -R nginx:nginx /usr/html
else
  chown -R nginx:nginx /usr/html
fi

chown -R nginx:nginx /usr/html

find /usr/html -type f | xargs chmod 664
find /usr/html -type d | xargs chmod 775
find /usr/html -type d | xargs chmod +s

# start php-fpm
mkdir -p /usr/logs/php-fpm
php-fpm7

# start nginx
mkdir -p /usr/logs/nginx
mkdir -p /tmp/nginx
chown nginx /tmp/nginx
nginx
