# Docker Images

For documentation please see the [wiki](https://github.com/bencgreen/docker/wiki).

The following Docker images make up the bcg|design ecosystem:

Source                                                           | Release                                                                                                   | Builds                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Image                                                                                                                                                                                                    | Versions                                                                                                                                                                                    | Hub Image
:--------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :-------------------------------------------------------
[Alpine S6](https://github.com/bencgreen/docker-alpine-s6)       | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-alpine-s6)    | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-alpine-s6/3.12-dev?label=github+3.12)<br>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-alpine-s6/3.13-dev?label=github+3.13)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/alpine-s6?label=docker)                                                                                                                              | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/alpine-s6?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/alpine-s6/latest?label=size)      | Base: [Alpine Linux](https://github.com/alpinelinux/docker-alpine) 3.13.1<br>[S6 Overlay](https://github.com/just-containers/s6-overlay) 2.2.0.1                                            | [Docker](https://hub.docker.com/r/bcgdesign/alpine-s6) 
[ASP.NET](https://github.com/bencgreen/docker-aspnet)            | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-aspnet)       | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-aspnet/3.1-dev?label=github+3.1)<br>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-aspnet/5.0-dev?label=github+5.0)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/aspnet?label=docker)                                                                                                                                           | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/aspnet?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/aspnet/latest?label=size)            | Base: [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)<br>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 3.1.11<br>[ASP.NET](https://dotnet.microsoft.com/apps/aspnet) 5.0.2 | [Docker](https://hub.docker.com/r/bcgdesign/aspnet)    
[Apache PHP](https://github.com/bencgreen/docker-apache-php)     | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-apache-php)   | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-apache-php/5.6-dev?label=github+5.6)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/apache-php?label=docker)                                                                                                                                                                                                                                                                | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/apache-php?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/apache-php/latest?label=size)    | Base: [PHP Apache](https://github.com/docker-library/php) 5.6.40                                                                                                                            | [Docker](https://hub.docker.com/r/bcgdesign/apache-php)    
[ClamAV](https://github.com/bencgreen/docker-clamav)             | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-clamav)       | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-clamav/build-dev?label=github)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/clamav?label=docker)                                                                                                                                                                                                                                                                          | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/clamav?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/clamav/latest?label=size)            | Base: [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)<br>[ClamAV](https://www.clamav.net) 0.103.1                                                                                | [Docker](https://hub.docker.com/r/bcgdesign/clamav)    
[MariaDB](https://github.com/bencgreen/docker-mariadb)           | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-mariadb)      | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-mariadb/build-dev?label=github)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/mariadb?label=docker)                                                                                                                                                                                                                                                                        | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/mariadb?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/mariadb/latest?label=size)          | Base: [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)<br>[MariaDB](https://mariadb.org) 10.5.8                                                                                   | [Docker](https://hub.docker.com/r/bcgdesign/mariadb)   
[Nginx](https://github.com/bencgreen/docker-nginx)               | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx)        | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx/alpine-3.12-dev?label=github+3.12)<br>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx/alpine-3.13-dev?label=github+3.13)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx?label=docker)                                                                                                                            | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx?label=pulls)<br>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx/latest?label=size)               | Base: [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)<br>[Nginx](https://nginx.org/en/) 1.18.0                                                                                   | [Docker](https://hub.docker.com/r/bcgdesign/nginx)     
[Nginx PHP](https://github.com/bencgreen/docker-nginx-php)       | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx-php)    | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/7.3-dev?label=github+7.3)<br>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/7.4-dev?label=github+7.4)<br>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/8.0-edge?label=github+8.0)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-php?label=docker) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-php?label=pulls)<br>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-php/latest?label=size)       | Base: [Nginx](https://github.com/bencgreen/docker-nginx)<br>[PHP](https://php.net) 7.3.27<br>[PHP](https://php.net) 7.4.15<br>[PHP](https://php.net) 8.0.2                                  | [Docker](https://hub.docker.com/r/bcgdesign/nginx-php) 
[Nginx Proxy](https://github.com/bencgreen/docker-nginx-proxy)   | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx-proxy)  | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-proxy/build-dev?label=github)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-proxy?label=docker)                                                                                                                                                                                                                                                                | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-proxy?label=pulls)<br>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-proxy/latest?label=size)   | Base: [Nginx](https://github.com/bencgreen/docker-nginx)<br>[getssl](https://github.com/srvrco/getssl) 2.33                                                                                 | [Docker](https://hub.docker.com/r/bcgdesign/nginx-proxy) 
[Nginx WebDAV](https://github.com/bencgreen/docker-nginx-webdav) | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx-webdav) | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-webdav/build-dev?label=github)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-webdav?label=docker)                                                                                                                                                                                                                                                              | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-webdav?label=pulls)<br>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-webdav/latest?label=size) | Base: [Nginx](https://github.com/bencgreen/docker-webdav)                                                                                                                                   | [Docker](https://hub.docker.com/r/bcgdesign/nginx-webdav) 
[Redis](https://github.com/bencgreen/docker-redis)               | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-redis)        | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-redis/build-dev?label=github)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/redis?label=docker)                                                                                                                                                                                                                                                                            | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/redis?label=pulls)<br>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/redis/latest?label=size)               | Base: [Redis Alpine](https://github.com/docker-library/redis) 6.0.10                                                                                                                        | [Docker](https://hub.docker.com/r/bcgdesign/redis)

## Applications

The following appliances are built using the images above.

Source                                                     | Release                                                                                                | Builds                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Image                                                                                                                                                                                              | Versions                                                                                                               | Hub Image
:--------------------------------------------------------- | :----------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------- | :-----------------------------------------------------
[WordPress](https://github.com/bencgreen/docker-wordpress) | ![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-wordpress) | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/7.3-dev?label=github+7.3)<br>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/7.4-dev?label=github+7.4)<br>![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/8.0-edge?label=github+8.0)<br>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/wordpress?label=docker)  | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/wordpress?label=pulls)<br>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/wordpress/latest?label=size) | Base: [Nginx PHP](https://github.com/bencgreen/docker-nginx-php)<br>Installs [WordPress](https://wordpress.org) latest | [Docker](https://hub.docker.com/r/bcgdesign/wordpress)
