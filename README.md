# Docker Images

For documentation please see the [wiki](https://github.com/bencgreen/docker/wiki).

The following Docker images make up the bcg|design ecosystem:

| Image                                                                                                                                                                                                                     | GitHub Builds                                                                                                                                                                                                                                                                                                                                                                                                                      | Stats                                                                                                                                                                                                     | Versions                                                                                                                                                                                                                                                                           | Docker Hub                                                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <br/>[**Alpine S6**](https://github.com/bencgreen/docker-alpine-s6)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-alpine-s6)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-alpine-s6?label=when)       | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-alpine-s6/dev-alpine3_12?label=alpine+3.12&logo=alpine)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-alpine-s6/dev-alpine3_13?label=alpine+3.13)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-alpine-s6/dev-alpineedge?label=alpine+edge) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/alpine-s6?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/alpine-s6/latest?label=size)       | Base: [Alpine Linux](https://github.com/alpinelinux/docker-alpine)<br/>[Alpine](https://alpinelinux.org/) 3.12.7<br/>[Alpine](https://alpinelinux.org/) 3.13.5<br/>[Alpine](https://alpinelinux.org/) Edge<br/>[S6 Overlay](https://github.com/just-containers/s6-overlay) 2.2.0.3 | [Repo](https://hub.docker.com/r/bcgdesign/alpine-s6)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/alpine-s6?label=docker)       |
| <br/>[**ASP.NET**](https://github.com/bencgreen/docker-aspnet)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-aspnet)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-aspnet?label=when)             | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-aspnet/dev-3_1?label=.NET+Core+3.1)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-aspnet/dev-5_0?label=.NET+Core+5.0)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-aspnet/dev-6_0?label=.NET+6.0)                                          | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/aspnet?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/aspnet/latest?label=size)             | Base: [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 3.1.15<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 5.0.6<br/>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 6.0.0.preview.4              | [Repo](https://hub.docker.com/r/bcgdesign/aspnet)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/aspnet?label=docker)             |
| <br/>[**Apache PHP**](https://github.com/bencgreen/docker-apache-php)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-apache-php)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-apache-php?label=when)     | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-apache-php/dev-5_6?label=PHP+5.6)                                                                                                                                                                                                                                                                                                         | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/apache-php?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/apache-php/latest?label=size)     | Base: [PHP Apache](https://github.com/docker-library/php) 5.6.40                                                                                                                                                                                                                   | [Repo](https://hub.docker.com/r/bcgdesign/apache-php)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/apache-php?label=docker)     |
| <br/>[**ClamAV**](https://github.com/bencgreen/docker-clamav)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-clamav)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-clamav?label=when)             | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-clamav/dev)                                                                                                                                                                                                                                                                                                                               | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/clamav?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/clamav/latest?label=size)             | Base: [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)<br/>[ClamAV](https://www.clamav.net) 0.103.2                                                                                                                                                                      | [Repo](https://hub.docker.com/r/bcgdesign/clamav)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/clamav?label=docker)             |
| <br/>[**FTPS**](https://github.com/bencgreen/docker-ftps)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-ftps)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-ftps?label=when)                 | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-ftps/dev)                                                                                                                                                                                                                                                                                                                                 | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/ftps?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/ftps/latest?label=size)                 | Base: [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)<br/>[vsftpd](https://security.appspot.com/vsftpd.html) 3.0.3                                                                                                                                                      | [Repo](https://hub.docker.com/r/bcgdesign/ftps)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/ftps?label=docker)                 |
| <br/>[**MariaDB**](https://github.com/bencgreen/docker-mariadb)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-mariadb)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-mariadb?label=when)           | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-mariadb/dev)                                                                                                                                                                                                                                                                                                                              | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/mariadb?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/mariadb/latest?label=size)           | Base: [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)<br/>[MariaDB](https://mariadb.org) 10.5.9                                                                                                                                                                         | [Repo](https://hub.docker.com/r/bcgdesign/mariadb)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/mariadb?label=docker)           |
| <br/>[**Nginx**](https://github.com/bencgreen/docker-nginx)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-nginx?label=when)               | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx/dev-alpine3_12?label=alpine+3.12)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx/dev-alpine3_13?label=alpine+3.13)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx/dev-alpineedge?label=alpine+edge)                         | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx/latest?label=size)               | Base: [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)<br/>[Nginx](https://nginx.org/en/) 1.18.0                                                                                                                                                                         | [Repo](https://hub.docker.com/r/bcgdesign/nginx)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx?label=docker)               |
| <br/>[**Nginx PHP**](https://github.com/bencgreen/docker-nginx-php)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx-php)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-nginx-php?label=when)       | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/dev-7_3?label=PHP+7.3)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/dev-7_4?label=PHP+7.4)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/dev-8_0?label=PHP+8.0)                                              | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-php?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-php/latest?label=size)       | Base: [Nginx](https://github.com/bencgreen/docker-nginx)<br/>[PHP](https://php.net) 7.3.27<br/>[PHP](https://php.net) 7.4.19<br/>[PHP](https://php.net) 8.0.6                                                                                                                      | [Repo](https://hub.docker.com/r/bcgdesign/nginx-php)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-php?label=docker)       |
| <br/>[**Nginx Proxy**](https://github.com/bencgreen/docker-nginx-proxy)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx-proxy)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-nginx-proxy?label=when)   | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-proxy/dev)                                                                                                                                                                                                                                                                                                                          | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-proxy?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-proxy/latest?label=size)   | Base: [Nginx](https://github.com/bencgreen/docker-nginx)<br/>[getssl](https://github.com/srvrco/getssl) 2.35                                                                                                                                                                       | [Repo](https://hub.docker.com/r/bcgdesign/nginx-proxy)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-proxy?label=docker)   |
| <br/>[**Nginx WebDAV**](https://github.com/bencgreen/docker-nginx-webdav)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx-webdav)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-nginx-webdav?label=when) | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-webdav/dev)                                                                                                                                                                                                                                                                                                                         | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-webdav?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-webdav/latest?label=size) | Base: [Nginx](https://github.com/bencgreen/docker-webdav)                                                                                                                                                                                                                          | [Repo](https://hub.docker.com/r/bcgdesign/nginx-webdav)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-webdav?label=docker) |
| <br/>[**Redis**](https://github.com/bencgreen/docker-redis)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-redis)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-redis?label=when)               | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-redis/dev)                                                                                                                                                                                                                                                                                                                                | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/redis?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/redis/latest?label=size)               | Base: [Redis Alpine](https://github.com/docker-library/redis) 6.2.3                                                                                                                                                                                                                | [Repo](https://hub.docker.com/r/bcgdesign/redis)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/redis?label=docker)               |

## Applications

The following appliances are built using the images above.

| Image                                                                                                                                                                                                               | GitHub Builds                                                                                                                                                                                                                                                                                                                                                                                  | Stats                                                                                                                                                                                               | Versions                                                                                                    | Hub Image                                                                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <br/>[**WordPress**](https://github.com/bencgreen/docker-wordpress)
| ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-wordpress)<br/>![GitHub Release Date](https://img.shields.io/github/release-date/bencgreen/docker-wordpress?label=when) | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/dev-php7_3?label=PHP+7.3)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/dev-php7_4?label=PHP+7.4)<br/>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/dev-php8_0?label=PHP+8.0) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/wordpress?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/wordpress/latest?label=size) | Base: [Nginx PHP](https://github.com/bencgreen/docker-nginx-php)<br/>[WordPress](https://wordpress.org) 5.7.2 | [Repo](https://hub.docker.com/r/bcgdesign/wordpress)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/wordpress?label=docker) |
