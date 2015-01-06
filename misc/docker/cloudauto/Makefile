VERSION = 0.0.2
NAME = pinterb

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME := $(shell basename $(PWD))
CREATE_DATE := $(shell date +%FT%T%Z)
DOCKER_BIN := $(shell which docker)

all: check_env build_docker tag_latest 

check_env:
ifndef DOCKER_BIN 
   $(error Docker does not appear to be installed.  If running Linux, please install Docker.  If running Windows or OS X, please run the )
endif

prep_docker:
	rm -rf cloud_provision_base_image
	cp -pR template cloud_provision_base_image
	sed -i 's/###-->ZZZ_IMAGE<--###/$(NAME)\/$(PROJECT_NAME)/g' cloud_provision_base_image/Dockerfile
	sed -i 's/###-->ZZZ_VERSION<--###/$(VERSION)/g' cloud_provision_base_image/Dockerfile
	sed -i 's/###-->ZZZ_BASE_IMAGE<--###/jpetazzo\/dind/g' cloud_provision_base_image/Dockerfile
	sed -i 's/###-->ZZZ_DATE<--###/$(CREATE_DATE)/g' cloud_provision_base_image/Dockerfile

build_docker: prep_docker
	$(DOCKER_BIN) build -t $(NAME)/$(PROJECT_NAME):$(VERSION) cloud_provision_base_image 

tag_latest:
	docker tag -f $(NAME)/$(PROJECT_NAME):$(VERSION) $(NAME)/$(PROJECT_NAME):latest

release: tag_latest
	@if ! docker images $(NAME)/$(PROJECT_NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)/$(PROJECT_NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)/$(PROJECT_NAME)

clean: clean_untagged
	rm -rf cloud_provision_base_image 

clean_untagged:
	for i in `docker ps --no-trunc -a -q`;do docker rm $$i;done
	docker images --no-trunc | grep none | awk '{print $$3}' | xargs -r docker rmi

.PHONY: all check_env prep_docker build_docker clean clean_untagged tag_latest release
