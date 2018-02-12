#!/bin/bash -x

docker run --name selfoss -d -p 8888:8888 jantman/docker-selfoss:latest
docker logs -f selfoss
