# Docker Images

## Contents

- [Base Images](#base-images)
- [Applications](#applications)

For documentation please see the [wiki](https://github.com/bfren/docker/wiki).

## Base Images

The following Docker images make up the bfren ecosystem:

| Image                                                             | Latest Release                                                                                                                                                                                                                  | Versions                                                                                                                                                                                                                                                                                                                         | Docker Hub                                                                                                                                                                                                                                                |
|------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [**Alpine S6**](https://github.com/bfren/docker-alpine-s6)        | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-alpine-s6?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-alpine-s6?label=date)       | Base: [Alpine Linux](https://github.com/alpinelinux/docker-alpine)<br/>[Alpine](https://alpinelinux.org/) 3.12.8<br/>[Alpine](https://alpinelinux.org/) 3.13.6<br/>[Alpine](https://alpinelinux.org/) 3.14.2<br/>[Alpine](https://alpinelinux.org/) Edge<br/>[S6 Overlay](https://github.com/just-containers/s6-overlay) 2.2.0.3 | [Repo](https://hub.docker.com/r/bfren/alpine-s6)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/alpine-s6?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/alpine-s6/latest?label=size)          |
| [**Apache PHP**](https://github.com/bfren/docker-apache-php)      | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-apache-php?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-apache-php?label=date)     | Base: [PHP Apache](https://github.com/docker-library/php) 5.6.40                                                                                                                                                                                                                                                                 | [Repo](https://hub.docker.com/r/bfren/apache-php)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/apache-php?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/apache-php/latest?label=size)       |
| [**ASP.NET**](https://github.com/bfren/docker-aspnet)             | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-aspnet?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-aspnet?label=date)             | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 3.1.18<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 5.0.9<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 6.0.0.preview.7                                                                | [Repo](https://hub.docker.com/r/bfren/aspnet)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/aspnet?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/aspnet/latest?label=size)                   |
| [**ClamAV**](https://github.com/bfren/docker-clamav)              | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-clamav?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-clamav?label=date)             | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[ClamAV](https://www.clamav.net) 0.103.3                                                                                                                                                                                                                        | [Repo](https://hub.docker.com/r/bfren/clamav)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/clamav?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/clamav/latest?label=size)                   |
| [**FTPS**](https://github.com/bfren/docker-ftps)                  | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-ftps?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-ftps?label=date)                 | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[vsftpd](https://security.appspot.com/vsftpd.html) 3.0.5                                                                                                                                                                                                        | [Repo](https://hub.docker.com/r/bfren/ftps)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/ftps?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/ftps/latest?label=size)                         |
| [**MariaDB**](https://github.com/bfren/docker-mariadb)            | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-mariadb?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-mariadb?label=date)           | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[MariaDB](https://mariadb.org) 10.4.21<br/>[MariaDB](https://mariadb.org) 10.5.12<br/>[MariaDB](https://mariadb.org) 10.6.4                                                                                                                                     | [Repo](https://hub.docker.com/r/bfren/mariadb)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/mariadb?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/mariadb/latest?label=size)                |
| [**Nginx**](https://github.com/bfren/docker-nginx)                | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx?label=date)               | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[Nginx](https://nginx.org/en/) 1.18.0<br/>[Nginx](https://nginx.org/en/) 1.20.1                                                                                                                                                                                 | [Repo](https://hub.docker.com/r/bfren/nginx)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/nginx?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/nginx/latest?label=size)                      |
| [**Nginx PHP**](https://github.com/bfren/docker-nginx-php)        | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-php?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx-php?label=date)       | Base: [Nginx](https://github.com/bfren/docker-nginx)<br/>[PHP](https://php.net) 7.3.30<br/>[PHP](https://php.net) 7.4.23<br/>[PHP](https://php.net) 8.0.10                                                                                                                                                                       | [Repo](https://hub.docker.com/r/bfren/nginx-php)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/nginx-php?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/nginx-php/latest?label=size)          |
| [**Nginx Proxy**](https://github.com/bfren/docker-nginx-proxy)    | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-proxy?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx-proxy?label=date)   | Base: [Nginx](https://github.com/bfren/docker-nginx)<br/>[getssl](https://github.com/srvrco/getssl) 2.41                                                                                                                                                                                                                         | [Repo](https://hub.docker.com/r/bfren/nginx-proxy)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/nginx-proxy?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/nginx-proxy/latest?label=size)    |
| [**Nginx WebDAV**](https://github.com/bfren/docker-nginx-webdav)  | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-webdav?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx-webdav?label=date) | Base: [Nginx](https://github.com/bfren/docker-webdav)                                                                                                                                                                                                                                                                            | [Repo](https://hub.docker.com/r/bfren/nginx-webdav)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/nginx-webdav?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/nginx-webdav/latest?label=size) |
| [**Redis**](https://github.com/bfren/docker-redis)                | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-redis?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-redis?label=date)               | Base: [Redis Alpine](https://github.com/docker-library/redis) 6.2.5                                                                                                                                                                                                                                                              | [Repo](https://hub.docker.com/r/bfren/redis)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/redis?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/redis/latest?label=size)                      |

## Applications

The following appliances are built using the images above.

| Image                                                        | Latest Release                                                                                                                                                                                                            | Versions                                                                                                   | Docker Hub                                                                                                                                                                                                                                       |
|------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [**FreeScout**](https://github.com/bfren/docker-freescout)   | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-freescout?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-freescout?label=date) | Base: [Nginx PHP](https://github.com/bfren/docker-nginx-php)<br/>[FreeScout](https://freescout.net) 1.7.16 | [Repo](https://hub.docker.com/r/bfren/freescout)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/freescout?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/freescout/latest?label=size) |
| [**FreshRSS**](https://github.com/bfren/docker-freshrss)     | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-freshrss?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-freshrss?label=date)   | Base: [Nginx PHP](https://github.com/bfren/docker-nginx-php)<br/>[FreshRSS](https://freshrss.org/) 1.18.1  | [Repo](https://hub.docker.com/r/bfren/freshrss)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/freshrss?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/freshrss/latest?label=size)    |
| [**WordPress**](https://github.com/bfren/docker-wordpress)   | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-wordpress?label=version)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-wordpress?label=date) | Base: [Nginx PHP](https://github.com/bfren/docker-nginx-php)<br/>[WordPress](https://wordpress.org) 5.8.1  | [Repo](https://hub.docker.com/r/bfren/wordpress)<br/>![Docker Pulls](https://img.shields.io/docker/pulls/bfren/wordpress?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/wordpress/latest?label=size) |
