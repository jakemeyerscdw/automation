VERSION = 0.0.1
NAME = cloudauto

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME := $(shell basename $(PWD))
CREATE_DATE := $(shell date +%FT%T%Z)
DOCKER_BIN := $(shell which docker)

all: check_env echo_env provision 

echo_env:
	@echo Your root directory: $(ROOT_DIR)
	@echo Your project: $(PROJECT_NAME)
	@echo DNSimple Email: $(DNSIMPLE_EMAIL)
	@echo DNSimple API Key: $(DNSIMPLE_API_KEY)
	@echo DigitalOcean Personal Access Token: $(DO_PAT)
	@echo ssh fingerprint: $(CLOUD_SSH_FINGERPRINT)

check_env:
ifndef DO_PAT
   $(error DO_PAT is undefined)
endif
ifndef DNSIMPLE_EMAIL 
   $(error DNSIMPLE_EMAIL is undefined)
endif 
ifndef DNSIMPLE_API_KEY 
   $(error DNSIMPLE_API_KEY is undefined)
endif
ifndef CLOUD_SSH_FINGERPRINT 
   $(error CLOUD_SSH_FINGERPRINT is undefined)
endif

#	sed -i 's/### SSH PUBLIC KEY ###/\/root\/.ssh\/id_rsa.pub/g' cloud_provision_base_image/tf/provider.tf 
prep_docker:
	rm -rf cloud_provision_base_image
	cp -pR docker cloud_provision_base_image 
	cp -pR terraform cloud_provision_base_image/tf
	sed -i 's/### DIGITALOCEAN PAT ###/$(DO_PAT)/g' cloud_provision_base_image/tf/provider.tf 
	sed -i 's/### SSH PRIVATE KEY ###/\/root\/.ssh\/id_rsa/g' cloud_provision_base_image/tf/www-1.tf 
	sed -i 's/### SSH FINGERPRINT ###/$(CLOUD_SSH_FINGERPRINT)/g' cloud_provision_base_image/tf/www-1.tf 

build_docker: prep_docker
	$(DOCKER_BIN) build -t $(NAME)/$(PROJECT_NAME):$(VERSION) cloud_provision_base_image 

provision: build_docker
	$(DOCKER_BIN) run -v /var/run/docker.sock:/var/run/docker.sock -t $(NAME)/$(PROJECT_NAME):$(VERSION) terraform version 
	$(DOCKER_BIN) run \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-e "DO_PAT=$(DO_PAT)" \
		-e "DNSIMPLE_EMAIL=$(DNSIMPLE_EMAIL)" \
		-e "DNSIMPLE_API_KEY=$(DNSIMPLE_API_KEY)" \
		-e "SSH_FINGERPRINT=$(CLOUD_SSH_FINGERPRINT)" \
		-it $(NAME)/$(PROJECT_NAME):$(VERSION) /bin/bash 

#		-v $(HOME)/.ssh:/root/.ssh:ro 
clean: clean_untagged
	rm -rf cloud_provision_base_image 

clean_untagged:
	for i in `docker ps --no-trunc -a -q`;do docker rm $$i;done
	docker images --no-trunc | grep none | awk '{print $$3}' | xargs -r docker rmi

.PHONY: all echo_env check_env prep_docker build_docker clean clean_untagged provision
