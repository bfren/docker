#!/bin/sh

docker pull --platform linux/arm/v7 golang:alpine
docker pull --platform linux/arm64 golang:alpine
docker pull --platform linux/amd64 golang:alpine
docker tag golang:alpine ghcr.io/bfren/golang:alpine
docker push ghcr.io/bfren/golang:alpine