FROM yobasystems/alpine:3.19.1-aarch64

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Dominic Taylor <dominic@yoba.systems>" \
    architecture="arm64v8/aarch64" \
    grav-version="1.7.44" \
    alpine-version="3.19.1" \
    build="11-Feb-2024" \
    org.opencontainers.image.title="alpine-grav" \
    org.opencontainers.image.description="Grav container image running on Alpine Linux" \
    org.opencontainers.image.authors="Dominic Taylor <dominic@yoba.systems>" \
    org.opencontainers.image.vendor="Yoba Systems" \
    org.opencontainers.image.version="1.7.44" \
    org.opencontainers.image.url="https://hub.docker.com/r/yobasystems/alpine-grav/" \
    org.opencontainers.image.source="https://github.com/yobasystems/alpine-grav" \
    org.opencontainers.image.base.name="docker.io/yobasystems/alpine:3.19.1" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

ENV TERM="xterm" \
    GRAV_VERSION="1.7.44"

RUN apk add --no-cache bash ca-certificates curl git less musl nginx tzdata vim yaml zip \
    php81-fpm php81-json php81-zlib php81-xml php81-pdo php81-phar php81-openssl \
    php81-gd php81-iconv php81-pecl-mcrypt php81-session php81-zip \
    php81-curl php81-opcache php81-ctype php81-apcu \
    php81-intl php81-bcmath php81-dom php81-mbstring php81-simplexml php81-xmlreader && \
    rm -rf /var/cache/apk/*

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php81/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php81/php.ini && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/usr:\/bin\/bash/g" /etc/passwd- && \
    ln -s /sbin/php-fpm7 /sbin/php-fpm

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php81/
ADD files/run.sh /
RUN chmod +x /run.sh


EXPOSE 80
VOLUME ["/usr"]
CMD ["/run.sh"]
