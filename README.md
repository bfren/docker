# Docker Images

The following Docker images make up the bcg|design ecosystem:

Source                                                         | Version                                                                                                               | Builds                                                                                                                                                                                                                                  | Image                                                                                                                                                                                                   | Versions                      | Link                                                  
:------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :---------------------------- | :-------------------------------------------------------
[Alpine S6](https://github.com/bencgreen/docker-alpine-s6)     | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/alpine-s6?sort=semver)   | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-alpine-s6/build?label=github)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/alpine-s6?label=docker)     | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/alpine-s6?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/alpine-s6/latest?label=size)     | Alpine 3.12.1 - S6 2.1.0.2    | [Docker](https://hub.docker.com/r/bcgdesign/alpine-s6) 
[ASP.NET](https://github.com/bencgreen/docker-aspnet)          | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/aspnet?sort=semver)      | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-aspnet/build?label=github)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/aspnet?label=docker)           | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/aspnet?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/aspnet/latest?label=size)           | Alpine S6 - ASP.NET 3.1.10    | [Docker](https://hub.docker.com/r/bcgdesign/aspnet)    
[ClamAV](https://github.com/bencgreen/docker-clamav)           | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/clamav?sort=semver)      | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-clamav/build?label=github)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/clamav?label=docker)           | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/clamav?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/clamav/latest?label=size)           | Alpine S6 - ClamAV 0.102.4    | [Docker](https://hub.docker.com/r/bcgdesign/clamav)    
[MariaDB](https://github.com/bencgreen/docker-mariadb)         | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/mariadb?sort=semver)     | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-mariadb/build?label=github)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/mariadb?label=docker)         | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/mariadb?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/mariadb/latest?label=size)         | Alpine S6 - MariaDB 10.5.6    | [Docker](https://hub.docker.com/r/bcgdesign/mariadb)   
[Nginx](https://github.com/bencgreen/docker-nginx)             | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/nginx?sort=semver)       | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx/build?label=github)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx?label=docker)             | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx/latest?label=size)             | Alpine S6 - Nginx 1.18.0      | [Docker](https://hub.docker.com/r/bcgdesign/nginx)     
[Nginx Proxy](https://github.com/bencgreen/docker-nginx-proxy) | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/nginx-proxy?sort=semver) | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-proxy/build?label=github)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-proxy?label=docker) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-proxy?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-proxy/latest?label=size) | Nginx - acme.sh               | [Docker](https://hub.docker.com/r/bcgdesign/nginx-proxy) 
[Nginx + PHP](https://github.com/bencgreen/docker-nginx-php)   | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/nginx-php?sort=semver)   | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx-php/build?label=github)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx-php?label=docker)     | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-php?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx-php/latest?label=size)     | Nginx - PHP 7.4.12            | [Docker](https://hub.docker.com/r/bcgdesign/nginx-php) 
[Redis](https://github.com/bencgreen/docker-redis)             | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/redis?sort=semver)       | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-redis/build?label=github)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/redis?label=docker)             | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/redis?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/redis/latest?label=size)             | Alpine 3.12 - Redis 6.0.9     | [Docker](https://hub.docker.com/r/bcgdesign/redis)     

Apart from Redis, all the images are based on the [Alpine S6](https://github.com/bencgreen/docker-alpine-s6) image.

## Applications

The following appliances are built using the images above.

App                                    | Source                                                     | Version                                                                                                             | Builds                                                                                                                                                                                                                              | Image                                                                                                                                                                                               | Versions                                  | Link                                                  
:------------------------------------- | :--------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------- | :-----------------------------------------------------
[WordPress.org](https://wordpress.org) |  [WordPress](https://github.com/bencgreen/docker-wordpress) | ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/bcgdesign/wordpress?sort=semver) | ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-wordpress/build?label=github)<br/>![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/wordpress?label=docker) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/wordpress?label=pulls)<br/>![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/wordpress/latest?label=size) | Nginx + PHP - <br>WordPress latest | [Docker](https://hub.docker.com/r/bcgdesign/wordpress) 
