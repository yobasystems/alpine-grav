FROM yobasystems/alpine:3.22.2-aarch64

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Dominic Taylor <dominic@yoba.systems>" \
    architecture="arm64v8/aarch64" \
    grav-version="1.7.49.5" \
    alpine-version="3.22.2" \
    build="30-Nov-2025" \
    org.opencontainers.image.title="alpine-grav" \
    org.opencontainers.image.description="Grav container image running on Alpine Linux" \
    org.opencontainers.image.authors="Dominic Taylor <dominic@yoba.systems>" \
    org.opencontainers.image.vendor="Yoba Systems" \
    org.opencontainers.image.version="1.7.49.5" \
    org.opencontainers.image.url="https://hub.docker.com/r/yobasystems/alpine-grav/" \
    org.opencontainers.image.source="https://github.com/yobasystems/alpine-grav" \
    org.opencontainers.image.base.name="docker.io/yobasystems/alpine:3.22.1" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

ENV TERM="xterm" \
    GRAV_VERSION="1.7.49.5"

RUN apk add --no-cache bash ca-certificates curl git less musl nginx tzdata vim yaml zip \
    php84-fpm php84-json php84-zlib php84-xml php84-pdo php84-phar php84-openssl \
    php84-gd php84-iconv php84-session php84-zip \
    php84-curl php84-opcache php84-ctype php84-apcu \
    php84-intl php84-bcmath php84-dom php84-mbstring php84-simplexml php84-xmlreader && \
    rm -rf /var/cache/apk/*

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php84/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php84/php.ini && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd- && \
    ln -s /sbin/php-fpm84 /sbin/php-fpm

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php84/
ADD files/run.sh /
RUN chmod +x /run.sh


EXPOSE 80
VOLUME ["/usr"]
CMD ["/run.sh"]
