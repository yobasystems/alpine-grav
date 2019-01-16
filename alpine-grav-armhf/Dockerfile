FROM balenalib/armv7hf-alpine
LABEL MAINTAINER fabrizio2210  architecture="ARM32v7/armhf" version="1.5.3" date="16-Gen-2019"
ENV TERM="xterm" \
    GRAV_VERSION="1.5.3"

RUN [ "cross-build-start" ]

RUN apk update && \
    apk add bash less vim nginx ca-certificates git tzdata curl yaml zip \
    php7-fpm php7-json php7-zlib php7-xml php7-pdo php7-phar php7-openssl \
    php7-gd php7-iconv php7-mcrypt php7-session php7-zip \
    php7-curl php7-opcache php7-ctype php7-apcu \
    php7-intl php7-bcmath php7-dom php7-mbstring php7-simplexml php7-xmlreader && apk add -u musl && \
    rm -rf /var/cache/apk/*

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php7/php.ini && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd- && \
    ln -s /sbin/php-fpm7 /sbin/php-fpm

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php7/
ADD files/run.sh /
RUN chmod +x /run.sh


RUN mkdir -p /usr/html && \
    curl -fLk -o /tmp/grav.zip  "https://github.com/getgrav/grav/releases/download/$GRAV_VERSION/grav-admin-v$GRAV_VERSION.zip" && \
  mkdir /tmp/grav-src && \
  unzip /tmp/grav.zip -d /tmp/grav-src && \
  mv -f /tmp/grav-src/grav-admin/* /usr/html/ && \
  rm -R /tmp/grav* && \
  chown -R nginx:nginx /usr/html  && \
  find /usr/html -type f | xargs chmod 664 && \
  find /usr/html -type d | xargs chmod 755 && \
  find /usr/html -type d | xargs chmod +s
  

RUN [ "cross-build-end" ]

EXPOSE 80
VOLUME ["/usr/html/user"]
CMD ["/run.sh"]
