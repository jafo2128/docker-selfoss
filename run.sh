#!/bin/bash -x

function cleanup {
  docker stop selfoss-test
  docker rm selfoss-test
}

trap cleanup EXIT
docker run --name selfoss-test -d -P jantman/docker-selfoss:latest
docker inspect --format='{{.NetworkSettings.Ports}}' selfoss-test
docker logs -f selfoss-test
