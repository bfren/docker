# Docker Images

## Base Images

### [Alpine S6](https://github.com/bencgreen/docker-alpine-s6)

This is the base image for the ecosystem, containing [Alpine Linux](https://github.com/alpinelinux/docker-alpine) installed with the [S6 Overlay](https://github.com/just-containers/s6-overlay).  Simple instructions can be found here - otherwise see their documentation for additional support.

### [ASP.NET](https://github.com/bencgreen/docker-aspnet)

This comes pre-installed with the .NET and [ASP.NET](https://dotnet.microsoft.com/apps/aspnet) runtimes.  Version numbers match the release of the .NET framework.

### [ClamAV](https://github.com/bencgreen/docker-clamav)

This tiny image comes pre-installed with [ClamAV](https://www.clamav.net), set up to run in daemon mode over the default port (3310).

### [MariaDB](https://github.com/bencgreen/docker-mariadb)

This image includes the latest stable release of [MariaDB](https://mariadb.org), with a built-in backup script that runs three times a day.

### [Nginx](https://github.com/bencgreen/docker-nginx)

[Nginx](https://nginx.org/en/) is a super-lightweight and powerful web server.  This base image is designed to be used behind a reverse proxy, as it only exposes port 80 and has no SSL support built-in.

### [Nginx PHP](https://github.com/bencgreen/docker-nginx-php)

Here is where Nginx starts to get interesting.  [PHP](https://php.net) runs in FPM mode - simply add your PHP files to the `/www` volume and connect.

### [Nginx Proxy](https://github.com/bencgreen/docker-nginx-proxy)

The most advanced of the images so far, this is a fully-automated (yet also fully customisable) reverse proxy image.  Simply define your primary domain names and aliases in two bash arrays, and the image does the rest: creating all the Nginx configuration files necessary to serve files over HTTPS, and then using [getssl](https://github.com/srvrco/getssl) to request certificates from [Lets Encrypt](https://letsencrypt.org).

### [Redis](https://github.com/bencgreen/docker-redis)

[Redis](https://github.com/docker-library/redis) is a fast caching application.  This uses the latest version, on the latest Alpine, with a custom healthcheck baked in to let you know whether or not it's healthy.

## Application Images

### [WordPress](https://github.com/bencgreen/docker-wordpress)

Based on the Nginx PHP image, this automatically installs the latest version of WordPress for the specified locale.  All PHP dependencies come pre-installed.
