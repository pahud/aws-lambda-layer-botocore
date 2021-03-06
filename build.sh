#!/bin/bash


docker build -t botocore . --build-arg DOCKER_MIRROR=${DOCKER_MIRROR-''}
CONTAINER=$(docker run -d botocore:latest false)
docker cp ${CONTAINER}:/root/layer.zip layer.zip
docker cp ${CONTAINER}:/root/VERSION VERSION
