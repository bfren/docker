# Docker Images

The following Docker images make up the bcg|design ecosystem:

Image | Release | Build | Docker | Pulls | Versions
:--- | :--- | :--- | :--- | :--- | :---
[Alpine S6](https://github.com/bencgreen/docker-alpine-s6) | 1.0.3 | ![build](https://github.com/bencgreen/docker-alpine-s6/workflows/build/badge.svg) | [Image](https://hub.docker.com/r/bcgdesign/alpine-s6) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/alpine-s6) | Alpine 3.12.1 - S6 2.1.0.2
[MariaDB](https://github.com/bencgreen/docker-mariadb) | 10.5.6 | ![build](https://github.com/bencgreen/docker-mariadb/workflows/build/badge.svg) | [Image](https://hub.docker.com/r/bcgdesign/mariadb) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/mariadb) | MariaDB 10.5.6
[Nginx](https://github.com/bencgreen/docker-nginx) | 1.18.0 | ![build](https://github.com/bencgreen/docker-nginx/workflows/build/badge.svg) | [Image](https://hub.docker.com/r/bcgdesign/nginx) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx) | Nginx 1.18.0
[Nginx + PHP](https://github.com/bencgreen/docker-nginx-php) | 7.4.12 | ![build](https://github.com/bencgreen/docker-nginx-php/workflows/build/badge.svg) | [Image](https://hub.docker.com/r/bcgdesign/nginx-php) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx-php) | Nginx 1.18.0 - PHP 7.4.12
[Redis](https://github.com/bencgreen/docker-redis) | 6.0.9 | ![build](https://github.com/bencgreen/docker-redis/workflows/build/badge.svg) | [Image](https://hub.docker.com/r/bcgdesign/redis) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/redis) | Alpine 3.12 - Redis 6.0.9
[WordPress](https://github.com/bencgreen/docker-wordpress) | 5.5.3 | ![build](https://github.com/bencgreen/docker-wordpress/workflows/build/badge.svg) | [Image](https://hub.docker.com/r/bcgdesign/wordpress) | ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/wordpress) | PHP 7.4.12 - WordPress 5.5.3

Apart from Redis, all the images are based on the [Alpine S6](https://github.com/bencgreen/docker-alpine-s6) image.
