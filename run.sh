#!/bin/bash -x

docker run --name selfoss-test -d -P jantman/docker-selfoss:latest
docker inspect --format='{{.NetworkSettings.Ports}}' selfoss-test
docker logs -f selfoss-test
