# Docker Ecosystem

## Contents

- [Base](#base)
- [Software](#software)
- [Applications](#applications)
- [Utilities](#utilities)

For documentation please see the [book](https://docs.bfren.dev/docker/) (work in progress!).

## Base

The following Docker images make up the bfren ecosystem:

| Image                                                      | Latest Release                                                                                                                                                                                                            | Versions                                                                                                                                                                | Docker Hub                                                                                                                                                                                                                                                                                                          |
|----------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [**Alpine**](https://github.com/bfren/docker-alpine)       | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-alpine?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-alpine?label=date)       | Base: [Alpine Linux](https://github.com/alpinelinux/docker-alpine)<br/>[Alpine](https://alpinelinux.org/) 3.8 to 3.16, and Edge                                         | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Falpine)](https://hub.docker.com/r/bfren/alpine)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Falpine)](https://hub.docker.com/r/bfren/alpine)             |
| [**Alpine S6**](https://github.com/bfren/docker-alpine-s6) | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-alpine-s6?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-alpine-s6?label=date) | Base: [Alpine](https://github.com/bfren/docker-alpine)<br/>[S6 Overlay](https://github.com/just-containers/s6-overlay) 3.1.2.1                                          | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Falpine-s6)](https://hub.docker.com/r/bfren/alpine-s6)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Falpine-s6)](https://hub.docker.com/r/bfren/alpine-s6) |
| [**Debian**](https://github.com/bfren/docker-debian)       | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-debian?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-debian?label=date)       | Base: [Debian Linux](https://github.com/debuerreotype/docker-debian-artifacts)<br/>[Debian](https://www.debian.org/) 10 (buster), 11 (bullseye), 12 (bookworm), and sid | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fdebian)](https://hub.docker.com/r/bfren/debian)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fdebian)](https://hub.docker.com/r/bfren/debian)             |
| [**Debian S6**](https://github.com/bfren/docker-debian-s6) | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-debian-s6?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-debian-s6?label=date) | Base: [Debian](https://github.com/bfren/docker-debian)<br/>[S6 Overlay](https://github.com/just-containers/s6-overlay) 3.1.2.1                                          | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fdebian-s6)](https://hub.docker.com/r/bfren/debian-s6)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fdebian-s6)](https://hub.docker.com/r/bfren/debian-s6) |

## Software

The following are built using the base images.

| Image                                                             | Latest Release                                                                                                                                                                                                                  | Versions                                                                                                                                                   | Docker Hub                                                                                                                                                                                                                                                                                                                      |
|------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [**Apache**](https://github.com/bfren/docker-apache)              | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-apache?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-apache?label=date)             | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[Apache](https://httpd.apache.org/) 2.4.43, and 2.4.54                                    | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fapache)](https://hub.docker.com/r/bfren/apache)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fapache)](https://hub.docker.com/r/bfren/apache)                         |
| [**Apache PHP**](https://github.com/bfren/docker-apache-php)      | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-apache-php?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-apache-php?label=date)     | Base: [Apache](https://github.com/bfren/docker-apache)<br/>[PHP](https://php.net) 5.6.40, 7.4.30, and 8.0.22                                               | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fapache-php)](https://hub.docker.com/r/bfren/apache-php)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fapache-php)](https://hub.docker.com/r/bfren/apache-php)         |
| [**ASP.NET**](https://github.com/bfren/docker-aspnet)             | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-aspnet?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-aspnet?label=date)             | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 3.1.28, 6.0.8, and 7.0.0-preview.7    | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Faspnet)](https://hub.docker.com/r/bfren/aspnet)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Faspnet)](https://hub.docker.com/r/bfren/aspnet)                         |
| [**ClamAV**](https://github.com/bfren/docker-clamav)              | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-clamav?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-clamav?label=date)             | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[ClamAV](https://www.clamav.net) 0.103.3, and 0.104.3                                     | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fclamav)](https://hub.docker.com/r/bfren/clamav)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fclamav)](https://hub.docker.com/r/bfren/clamav)                         |
| [**FTPS**](https://github.com/bfren/docker-ftps)                  | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-ftps?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-ftps?label=date)                 | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[vsftpd](https://security.appspot.com/vsftpd.html) 3.0.5                                  | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fftps)](https://hub.docker.com/r/bfren/ftps)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fftps)](https://hub.docker.com/r/bfren/ftps)                                 |
| [**MariaDB**](https://github.com/bfren/docker-mariadb)            | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-mariadb?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-mariadb?label=date)           | Base: [Debian S6](https://github.com/bfren/docker-debian-s6)<br/>[MariaDB](https://mariadb.org) 10.4.25, 10.5.17, 10.6.9 (LTS), 10.7.5, 10.8.4, and 10.9.2 | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fmariadb)](https://hub.docker.com/r/bfren/mariadb)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fmariadb)](https://hub.docker.com/r/bfren/mariadb)                     |
| [**Nginx**](https://github.com/bfren/docker-nginx)                | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx?label=date)               | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[Nginx](https://nginx.org/en/) 1.18.0, 1.20.2, and 1.22.0                                 | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnginx)](https://hub.docker.com/r/bfren/nginx)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnginx)](https://hub.docker.com/r/bfren/nginx)                             |
| [**Nginx PHP**](https://github.com/bfren/docker-nginx-php)        | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-php?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx-php?label=date)       | Base: [Nginx](https://github.com/bfren/docker-nginx)<br/>[PHP](https://php.net) 7.3.33, 7.4.30, 8.0.22, and 8.1.9                                          | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnginx-php)](https://hub.docker.com/r/bfren/nginx-php)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnginx-php)](https://hub.docker.com/r/bfren/nginx-php)             |
| [**Nginx Proxy**](https://github.com/bfren/docker-nginx-proxy)    | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-proxy?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx-proxy?label=date)   | Base: [Nginx](https://github.com/bfren/docker-nginx)<br/>[getssl](https://github.com/srvrco/getssl) 2.46                                                   | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnginx-proxy)](https://hub.docker.com/r/bfren/nginx-proxy)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnginx-proxy)](https://hub.docker.com/r/bfren/nginx-proxy)     |
| [**Nginx WebDAV**](https://github.com/bfren/docker-nginx-webdav)  | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-webdav?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx-webdav?label=date) | Base: [Nginx](https://github.com/bfren/docker-webdav)                                                                                                      | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnginx-webdav)](https://hub.docker.com/r/bfren/nginx-webdav)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnginx-webdav)](https://hub.docker.com/r/bfren/nginx-webdav) |
| [**Node**](https://github.com/bfren/docker-node)                  | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-node?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-node?label=date)                 | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[Node.js](https://nodejs.org) 14.20, 16.16, 17.10, and 18.6                               | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnode)](https://hub.docker.com/r/bfren/node)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnode)](https://hub.docker.com/r/bfren/node)                                 |
| [**PHP**](https://github.com/bfren/docker-php)                    | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-php?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-php?label=date)                   | Base: [Alpine](https://github.com/bfren/docker-alpine)<br/>[PHP](https://php.net) 7.3.33, 7.4.30, 8.0.22, 8.1.9, and 8.2.0                                 | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fphp)](https://hub.docker.com/r/bfren/php)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fphp)](https://hub.docker.com/r/bfren/php)                                     |
| [**PostgreSQL**](https://github.com/bfren/docker-postgresql)      | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-postgresql?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-postgresql?label=date)     | Base: [Alpine S6](https://github.com/bfren/docker-postgresql)<br/>[PostgreSQL](https://postgresql.org) 12.12, 13.8, and 14.5                               | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fpostgresql)](https://hub.docker.com/r/bfren/postgresql)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fpostgresql)](https://hub.docker.com/r/bfren/postgresql)         |
| [**Redis**](https://github.com/bfren/docker-redis)                | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-redis?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-redis?label=date)               | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[Redis](https://redis.io/) 6.2.7, and 7.0.4                                               | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fredis)](https://hub.docker.com/r/bfren/redis)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fredis)](https://hub.docker.com/r/bfren/redis)                             |

## Applications

The following appliances are built using the software images.

| Image                                                        | Latest Release                                                                                                                                                                                                            | Versions                                                                                                   | Docker Hub                                                                                                                                                                                                                                                                                                          |
|------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [**FreeScout**](https://github.com/bfren/docker-freescout)   | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-freescout?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-freescout?label=date) | Base: [Nginx PHP](https://github.com/bfren/docker-nginx-php)<br/>[FreeScout](https://freescout.net) 1.8.21 | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Ffreescout)](https://hub.docker.com/r/bfren/freescout)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Ffreescout)](https://hub.docker.com/r/bfren/freescout) |
| [**FreshRSS**](https://github.com/bfren/docker-freshrss)     | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-freshrss?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-freshrss?label=date)   | Base: [Nginx PHP](https://github.com/bfren/docker-nginx-php)<br/>[FreshRSS](https://freshrss.org/) 1.19.2  | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Ffreshrss)](https://hub.docker.com/r/bfren/freshrss)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Ffreshrss)](https://hub.docker.com/r/bfren/freshrss)     |
| [**WordPress**](https://github.com/bfren/docker-wordpress)   | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-wordpress?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-wordpress?label=date) | Base: [Nginx PHP](https://github.com/bfren/docker-nginx-php)<br/>[WordPress](https://wordpress.org) 6.0.1  | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fwordpress)](https://hub.docker.com/r/bfren/wordpress)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fwordpress)](https://hub.docker.com/r/bfren/wordpress) |

## Utilities

The following utilities are built using the images above.

| Image                                                                | Latest Release                                                                                                                                                                                                              | Versions                                               | Docker Hub                                                                                                                                                                                                                                                                                                              |
|--------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [**PostgreSQL Upgrade**](https://github.com/bfren/docker-pg-upgrade) | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-pg-upgrade?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-pg-upgrade?label=date) | Base: [Alpine](https://github.com/bfren/docker-alpine) | [![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fpg-upgrade)](https://hub.docker.com/r/bfren/pg-upgrade)<br/>[![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fpg-upgrade)](https://hub.docker.com/r/bfren/pg-upgrade) |
