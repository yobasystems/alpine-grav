# Grav container image running on Alpine Linux

[![Docker Automated build](https://img.shields.io/docker/automated/yobasystems/alpine-grav.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-grav/)
[![Docker Pulls](https://img.shields.io/docker/pulls/yobasystems/alpine-grav.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-grav/)
[![Docker Stars](https://img.shields.io/docker/stars/yobasystems/alpine-grav.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/yobasystems/alpine-grav/)

[![Alpine Version](https://img.shields.io/badge/Alpine%20version-v3.23.0-green.svg?style=for-the-badge)](https://alpinelinux.org/)
[![Grav Version](https://img.shields.io/badge/grav%20version-v1.7.49.5-green.svg?style=for-the-badge)](https://getgrav.org/)

This container image [(yobasystems/alpine-grav)](https://hub.docker.com/r/yobasystems/alpine-grav/) is based on the minimal [Alpine Linux](https://alpinelinux.org/) ready for running [Grav](https://getgrav.org/) (Flat file CMS)

### Alpine Version 3.23.0 (Released 2025-12-03)

##### Grav Version 1.7.49.5

---

## Table of Contents

- [What is Alpine Linux?](#what-is-alpine-linux)
- [Features](#features)
- [Architectures](#architectures)
- [Tags](#tags)
- [Layers & Sizes](#layers--sizes)
- [How to use this image](#how-to-use-this-image)
- [Image contents & Vulnerability analysis](#image-contents--vulnerability-analysis)
- [Source Repositories](#source-repositories)
- [Container Registries](#container-registries)
- [Links](#links)
- [Donation](#donation)

## 🏔️ What is Alpine Linux?

Alpine Linux is a Linux distribution built around musl libc and BusyBox. The image is only 5 MB in size and has access to a package repository that is much more complete than other BusyBox based images. This makes Alpine Linux a great image base for utilities and even production applications. Read more about Alpine Linux here and you can see how their mantra fits in right at home with container images.

## ✨ Features

- Minimal size only, minimal layers
- Memory usage is minimal on a simple install.

## 🏗️ Architectures

- `:amd64`, `:x86_64` - 64 bit Intel/AMD (x86_64/amd64)
- `:arm64v8`, `:aarch64` - 64 bit ARM (ARMv8/aarch64)
- `:arm32v7`, `:armhf` - 32 bit ARM (ARMv7/armhf)

## 🏷️ Tags

- `:latest` latest branch based (Automatic Architecture Selection)
- `:main` main branch usually inline with latest
- `:deliver-site` deliver-site branch based (Automatic Architecture Selection)
- `:one-page` one-page branch based (Automatic Architecture Selection)
- `:amd64`, `:x86_64` amd64 based on latest tag but amd64 architecture
- `:aarch64`, `:arm64v8` Armv8 based on latest tag but arm64 architecture
- `:armhf`, `:arm32v7` Armv7 based on latest tag but arm32 architecture

## 📏 Layers & Sizes

![Version](https://img.shields.io/badge/version-amd64-blue.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/yobasystems/alpine-grav/amd64.svg?style=for-the-badge)

![Version](https://img.shields.io/badge/version-aarch64-blue.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/yobasystems/alpine-grav/aarch64.svg?style=for-the-badge)

![Version](https://img.shields.io/badge/version-armhf-blue.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/yobasystems/alpine-grav/armhf.svg?style=for-the-badge)

## 🚀 How to use this image

## Environment Variables:

## Creating an instance

```bash
mkdir -p /data/{domain}/html

docker run -e VIRTUAL_HOST={domain}.com,www.{domain}.com -v /data/{domain}/html:/usr/html -p 80:80 yobasystems/alpine-grav
```

E.G

```bash
mkdir -p /data/yobasystems/html

docker run -e VIRTUAL_HOST=yoba.systems -v /data/yobasystems/html:/usr/html -p 80:80 yobasystems/alpine-grav
```

Make sure you create the folder on the host before starting the container and obtain the correct permissions.

```bash

mkdir -p /data/{domain}/html

docker run -e VIRTUAL_HOST={domain}.com,www.{domain}.com -v /data/{domain}/html:/usr/html -p 80:80 yobasystems/alpine-grav:latest

E.G

mkdir -p /data/example-com/html

docker run -e VIRTUAL_HOST=example.com -v /data/example-com/html:/usr/html -p 80:80 yobasystems/alpine-grav:latest
```

The following user and group id are used, the files should be set to this:
User ID:
Group ID:

```bash
chown -R 100:101 /data/{domain}/html

E.G

chown -R 100:101 /data/example-com/html
```

The container image will auto create the folder and populate with files if it doesn't exist. Make sure to mount /data/{domain}/html with your Backup files.

The following user and group id are used, the files should be set to this:
User ID:
Group ID:

```bash
chown -R 100:101 /data/{domain}/html
```

### Volume structure

- `/usr/html`: Webroot

### GRAV CLI GPM

Grav includes a GPM (Grav Package Manager) which allows you to install, update, uninstall and list all the themes and plugins available on the Grav repository, as well as upgrade Grav itself to the latest version. Its best to `su nginx` before executing anything or else you can potentially compromise your host.

```bash
docker exec -it <container_name> bash
su nginx
cd /usr/html
bin/gpm list

```

### Upload limit

The upload limit is 128 Megabytes.

### Change php.ini value

modify files/php-fpm.conf

To modify php.ini variable, simply edit php-fpm.ini and add php_flag[variable] = value.

```php
php_flag[display_errors] = on
```

### PHP Modules

#### List of available modules in Alpine Linux, not all these are installed.

##### In order to install a php module do, (leave out the version number i.e. -8.1.01-r0

```bash
docker exec <image_id> apk add <pkg_name>
docker restart <image_name>
```

Example:

```bash
docker exec <image_id> apk add php84-soap
docker restart <image_name>
```

```
php84-common
php84-pdo_sqlite
php84-pear
php84-ftp
php84-imap
php84-mysqli
php84-json
php84-mbstring
php84-soap
php84-litespeed
php84-sockets
php84-bcmath
php84-opcache
php84-dom
php84-zlib
php84-gettext
php84-fpm
php84-intl
php84-openssl
php84-session
php84-pdo_mysql
php84-embed
php84-xmlrpc
php84-wddx
php84-dba
php84-ldap
php84-xsl
php84-exif
php84-pdo_dblib
php84-bz2
php84-pdo
php84-pspell
php84-sysvmsg
php84-gmp
php84-apache2
php84-pdo_odbc
php84-shmop
php84-ctype
php84-phpdbg
php84-enchant
php84-sysvsem
php84-sqlite3
php84-odbc
php84-pcntl
php84-calendar
php84-xmlreader
php84-snmp
php84-zip
php84-posix
php84-iconv
php84-curl
php84-doc
php84-gd
php84-xml
php84-dev
php84-cgi
php84-sysvshm
php84-pgsql
php84-tidy
php84-pdo_pgsql
php84-phar
php84-mysqlnd
```

## Docker Compose example:

```yaml
grav:
  image: yobasystems/alpine-grav:latest
  environment:
    VIRTUAL_HOST: example.com
  expose:
    - "80"
  volumes:
    - /data/example-com/www:/usr/html
  restart: always
```

## 🔍 Image contents & Vulnerability analysis

| PACKAGE NAME | PACKAGE VERSION | VULNERABILITIES |
| ------------ | --------------- | --------------- |

## 📚 Source Repositories

- [Github - yobasystems/alpine-grav](https://github.com/yobasystems/alpine-grav)
- [Gitlab - yobasystems/alpine-grav](https://gitlab.com/yobasystems/alpine-grav)

## 🐳 Container Registries

- [Dockerhub - yobasystems/alpine-grav](https://hub.docker.com/r/yobasystems/alpine-grav/)
- [Quay.io - yobasystems/alpine-grav](https://quay.io/repository/yobasystems/alpine-grav)

## 🔗 Links

- [Yoba Systems](https://yoba.systems/)
- [Github - Yoba Systems](https://github.com/yobasystems/)
- [Dockerhub - Yoba Systems](https://hub.docker.com/u/yobasystems/)
- [Quay.io - Yoba Systems](https://quay.io/organization/yobasystems)
- [Maintainer - Dominic Taylor](https://github.com/dominictayloruk)
