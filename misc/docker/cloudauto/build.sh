#!/bin/sh
docker build -t pinterb/cloudauto_build .
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) -ti --name cloudauto_build pinterb/cloudauto_build
docker rm cloudauto_build
docker rmi pinterb/cloudauto_build
docker run -v ${PWD}:/data --rm -ti pinterb/cloudauto:latest readme.sh
