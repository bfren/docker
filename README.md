# Docker Images

For documentation please see the [wiki](https://github.com/bfren/docker/wiki).

The following Docker images make up the bfren ecosystem:

| Image                                                                                                                                                                                                             | GitHub Builds                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | Stats                                                                                                                                                                                             | Versions                                                                                                                                                                                                                                                                                                                         | Docker Hub                                          |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| <br/>[**Alpine S6**](https://github.com/bfren/docker-alpine-s6)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-alpine-s6)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-alpine-s6?label=when)       | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-alpine-s6/dev-alpine3_12?label=Alpine+3.12&logo=alpine)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-alpine-s6/dev-alpine3_13?label=Alpine+3.13)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-alpine-s6/dev-alpine3_13?label=Alpine+3.14)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-alpine-s6/dev-alpineedge?label=Alpine+Edge) | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/alpine-s6?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/alpine-s6/latest?label=size)       | Base: [Alpine Linux](https://github.com/alpinelinux/docker-alpine)<br/>[Alpine](https://alpinelinux.org/) 3.12.8<br/>[Alpine](https://alpinelinux.org/) 3.13.6<br/>[Alpine](https://alpinelinux.org/) 3.14.2<br/>[Alpine](https://alpinelinux.org/) Edge<br/>[S6 Overlay](https://github.com/just-containers/s6-overlay) 2.2.0.3 | [Repo](https://hub.docker.com/r/bfren/alpine-s6)    |
| <br/>[**Apache PHP**](https://github.com/bfren/docker-apache-php)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-apache-php)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-apache-php?label=when)     | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-apache-php/dev-5_6?label=PHP+5.6)                                                                                                                                                                                                                                                                                                                                                                                                                                      | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/apache-php?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/apache-php/latest?label=size)     | Base: [PHP Apache](https://github.com/docker-library/php) 5.6.40                                                                                                                                                                                                                                                                 | [Repo](https://hub.docker.com/r/bfren/apache-php)   |
| <br/>[**ASP.NET**](https://github.com/bfren/docker-aspnet)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-aspnet)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-aspnet?label=when)             | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-aspnet/dev-3_1?label=.NET+Core+3.1)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-aspnet/dev-5_0?label=.NET+5.0)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-aspnet/dev-6_0?label=.NET+6.0)                                                                                                                                                                                    | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/aspnet?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/aspnet/latest?label=size)             | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 3.1.18<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 5.0.9<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 6.0.0.preview.7                                                                | [Repo](https://hub.docker.com/r/bfren/aspnet)       |
| <br/>[**ClamAV**](https://github.com/bfren/docker-clamav)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-clamav)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-clamav?label=when)             | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-clamav/dev)                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/clamav?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/clamav/latest?label=size)             | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[ClamAV](https://www.clamav.net) 0.103.3                                                                                                                                                                                                                        | [Repo](https://hub.docker.com/r/bfren/clamav)       |
| <br/>[**FTPS**](https://github.com/bfren/docker-ftps)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-ftps)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-ftps?label=when)                 | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-ftps/dev)                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/ftps?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/ftps/latest?label=size)                 | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[vsftpd](https://security.appspot.com/vsftpd.html) 3.0.4                                                                                                                                                                                                        | [Repo](https://hub.docker.com/r/bfren/ftps)         |
| <br/>[**MariaDB**](https://github.com/bfren/docker-mariadb)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-mariadb)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-mariadb?label=when)           | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-mariadb/dev-10_4?label=MariaDB+10.4)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-mariadb/dev-10_5?label=MariaDB+10.5)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-mariadb/dev-10_6?label=MariaDB+10.6)                                                                                                                                                                       | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/mariadb?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/mariadb/latest?label=size)           | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[MariaDB](https://mariadb.org) 10.4.21<br/>[MariaDB](https://mariadb.org) 10.5.12<br/>[MariaDB](https://mariadb.org) 10.6.4                                                                                                                                     | [Repo](https://hub.docker.com/r/bfren/mariadb)      |
| <br/>[**Nginx**](https://github.com/bfren/docker-nginx)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx?label=when)               | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx/dev-alpine3_12?label=Alpine+3.12)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx/dev-alpine3_13?label=Alpine+3.13)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx/dev-alpine3_14?label=Alpine+3.14)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx/dev-alpineedge?label=Alpine+Edge)                             | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/nginx?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/nginx/latest?label=size)               | Base: [Alpine S6](https://github.com/bfren/docker-alpine-s6)<br/>[Nginx](https://nginx.org/en/) 1.18.0<br/>[Nginx](https://nginx.org/en/) 1.20.1                                                                                                                                                                                 | [Repo](https://hub.docker.com/r/bfren/nginx)        |
| <br/>[**Nginx PHP**](https://github.com/bfren/docker-nginx-php)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-php)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx-php?label=when)       | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx-php/dev-7_3?label=PHP+7.3)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx-php/dev-7_4?label=PHP+7.4)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx-php/dev-8_0?label=PHP+8.0)                                                                                                                                                                                   | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/nginx-php?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/nginx-php/latest?label=size)       | Base: [Nginx](https://github.com/bfren/docker-nginx)<br/>[PHP](https://php.net) 7.3.30<br/>[PHP](https://php.net) 7.4.23<br/>[PHP](https://php.net) 8.0.10                                                                                                                                                                       | [Repo](https://hub.docker.com/r/bfren/nginx-php)    |
| <br/>[**Nginx Proxy**](https://github.com/bfren/docker-nginx-proxy)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-proxy)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx-proxy?label=when)   | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx-proxy/dev)                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/nginx-proxy?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/nginx-proxy/latest?label=size)   | Base: [Nginx](https://github.com/bfren/docker-nginx)<br/>[getssl](https://github.com/srvrco/getssl) 2.41                                                                                                                                                                                                                         | [Repo](https://hub.docker.com/r/bfren/nginx-proxy)  |
| <br/>[**Nginx WebDAV**](https://github.com/bfren/docker-nginx-webdav)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx-webdav)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-nginx-webdav?label=when) | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx-webdav/dev)                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/nginx-webdav?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/nginx-webdav/latest?label=size) | Base: [Nginx](https://github.com/bfren/docker-webdav)                                                                                                                                                                                                                                                                            | [Repo](https://hub.docker.com/r/bfren/nginx-webdav) |
| <br/>[**Redis**](https://github.com/bfren/docker-redis)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-redis)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-redis?label=when)               | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-redis/dev)                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/redis?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/redis/latest?label=size)               | Base: [Redis Alpine](https://github.com/docker-library/redis) 6.2.5                                                                                                                                                                                                                                                              | [Repo](https://hub.docker.com/r/bfren/redis)        |

## Applications

The following appliances are built using the images above.

| Image                                                                                                                                                                                                       | GitHub Builds                                                                                                                                                                                                                                                                                                                                                                      | Stats                                                                                                                                                                                       | Versions                                                                                                   | Hub Image                                        |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| <br/>[**FreeScout**](https://github.com/bfren/docker-freescout)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-freescout)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-freescout?label=when) | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-freescout/dev?label=PHP+7.4)                                                                                                                                                                                                                                                                  | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/freescout?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/freescout/latest?label=size) | Base: [Nginx PHP](https://github.com/bfren/docker-nginx-php)<br/>[FreeScout](https://freescout.net) 1.7.16 | [Repo](https://hub.docker.com/r/bfren/freescout) |
| <br/>[**FreshRSS**](https://github.com/bfren/docker-freshrss)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-freshrss)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-freshrss?label=when)   | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-freshrss/dev?label=PHP+8.0)                                                                                                                                                                                                                                                                   | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/freshrss?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/freshrss/latest?label=size)   | Base: [Nginx PHP](https://github.com/bfren/docker-nginx-php)<br/>[FreshRSS](https://freshrss.org/) 1.18.1  | [Repo](https://hub.docker.com/r/bfren/freshrss)  |
| <br/>[**WordPress**](https://github.com/bfren/docker-wordpress)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-wordpress)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bfren/docker-wordpress?label=when) | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-wordpress/dev-php7_3?label=PHP+7.3)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-wordpress/dev-php7_4?label=PHP+7.4)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-wordpress/dev-php8_0?label=PHP+8.0) | ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/wordpress?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/wordpress/latest?label=size) | Base: [Nginx PHP](https://github.com/bfren/docker-nginx-php)<br/>[WordPress](https://wordpress.org) 5.8    | [Repo](https://hub.docker.com/r/bfren/wordpress) |
