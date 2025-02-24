FROM yobasystems/alpine:3.21.2-armhf

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Dominic Taylor <dominic@yoba.systems>" \
    architecture="arm32v7/armhf" \
    grav-version="1.7.46" \
    alpine-version="3.20.2" \
    build="19-Aug-2024" \
    org.opencontainers.image.title="alpine-grav" \
    org.opencontainers.image.description="Grav container image running on Alpine Linux" \
    org.opencontainers.image.authors="Dominic Taylor <dominic@yoba.systems>" \
    org.opencontainers.image.vendor="Yoba Systems" \
    org.opencontainers.image.version="1.7.46" \
    org.opencontainers.image.url="https://hub.docker.com/r/yobasystems/alpine-grav/" \
    org.opencontainers.image.source="https://github.com/yobasystems/alpine-grav" \
    org.opencontainers.image.base.name="docker.io/yobasystems/alpine:3.20.2" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

ENV TERM="xterm" \
    GRAV_VERSION="1.7.46"

RUN apk add --no-cache bash ca-certificates curl git less musl nginx tzdata vim yaml zip \
    php83-fpm php83-json php83-zlib php83-xml php83-pdo php83-phar php83-openssl \
    php83-gd php83-iconv php83-pecl-mcrypt php83-session php83-zip \
    php83-curl php83-opcache php83-ctype php83-apcu \
    php83-intl php83-bcmath php83-dom php83-mbstring php83-simplexml php83-xmlreader && \
    rm -rf /var/cache/apk/*

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php83/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php83/php.ini && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd- && \
    ln -s /sbin/php-fpm7 /sbin/php-fpm

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php83/
ADD files/run.sh /
RUN chmod +x /run.sh


EXPOSE 80
VOLUME ["/usr"]
CMD ["/run.sh"]
