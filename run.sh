#!/bin/bash

docker run --name selfoss -d -P jantman/docker-selfoss:latest
docker logs -f selfoss
