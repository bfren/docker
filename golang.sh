#!/bin/bash

PLATFORMS=(linux/arm/v7 linux/arm64 linux/amd64)

for P in ${PLATFORMS[@]}; do
    docker pull --platform ${P} golang:alpine
done

docker tag golang:alpine ghcr.io/bfren/golang:alpine

for P in ${PLATFORMS[@]}; do
    docker push --platform ${P} ghcr.io/bfren/golang:alpine
done
