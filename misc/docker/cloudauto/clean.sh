#!/bin/sh

for i in `docker ps --no-trunc -a -q`;do docker rm $i;done
docker images --no-trunc | grep none | awk '{print $3}' | xargs -r docker rmi
