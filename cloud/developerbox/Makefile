VERSION = 0.0.1
NAME = cloudauto

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME := $(shell basename $(PWD))
CREATE_DATE := $(shell date +%FT%T%Z)
DOCKER_BIN := $(shell which docker)
PROVISION_OUTPUT :=${PWD}/provisionstatus

all: check_env echo_env run 

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
ifndef CLOUD_SSH_KEYS_HOME 
   $(error CLOUD_SSH_KEYS_HOME is undefined)
endif
ifndef CLOUD_SSH_FINGERPRINT 
   $(error CLOUD_SSH_FINGERPRINT is undefined)
endif

prep_docker:
	rm -rf cloud_provision_base_image
	cp -pR docker cloud_provision_base_image 
	cp -pR terraform cloud_provision_base_image/tf
	mkdir cloud_provision_base_image/ssh
	cp -pR /home/pinter/.ssh/id_rsa* cloud_provision_base_image/ssh/
	sed -i 's/### DIGITALOCEAN PAT ###/$(DO_PAT)/g' cloud_provision_base_image/tf/*.tf 
	sed -i 's/### SSH PRIVATE KEY ###/\/root\/.ssh\/id_rsa/g' cloud_provision_base_image/tf/*.tf 
	sed -i 's/### SSH FINGERPRINT ###/$(CLOUD_SSH_FINGERPRINT)/g' cloud_provision_base_image/tf/*.tf 

build: prep_docker
	$(DOCKER_BIN) build -t $(NAME)/$(PROJECT_NAME):$(VERSION) cloud_provision_base_image 

mkdirs: 
	mkdir -p $(PROVISION_OUTPUT) 
	
run: build mkdirs
	$(DOCKER_BIN) run \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PROVISION_OUTPUT):/tf/plans:rw \
		-e "DO_PAT=$(DO_PAT)" \
		-e "DNSIMPLE_EMAIL=$(DNSIMPLE_EMAIL)" \
		-e "DNSIMPLE_API_KEY=$(DNSIMPLE_API_KEY)" \
		-e "SSH_FINGERPRINT=$(CLOUD_SSH_FINGERPRINT)" \
		-it $(NAME)/$(PROJECT_NAME):$(VERSION) /bin/bash 

plan: mkdirs 
	$(DOCKER_BIN) run \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PROVISION_OUTPUT):/tf/plans:rw \
		-e "DO_PAT=$(DO_PAT)" \
		-e "DNSIMPLE_EMAIL=$(DNSIMPLE_EMAIL)" \
		-e "DNSIMPLE_API_KEY=$(DNSIMPLE_API_KEY)" \
		-e "SSH_FINGERPRINT=$(CLOUD_SSH_FINGERPRINT)" \
		-it $(NAME)/$(PROJECT_NAME):$(VERSION) terraform plan -state=/tf/plans/terraform.tfstate -refresh=true -backup=/tf/plans/terraform.tfstate.backup 

provision: mkdirs
	$(DOCKER_BIN) run \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PROVISION_OUTPUT):/tf/plans:rw \
		-e "DO_PAT=$(DO_PAT)" \
		-e "DNSIMPLE_EMAIL=$(DNSIMPLE_EMAIL)" \
		-e "DNSIMPLE_API_KEY=$(DNSIMPLE_API_KEY)" \
		-e "SSH_FINGERPRINT=$(CLOUD_SSH_FINGERPRINT)" \
		-it $(NAME)/$(PROJECT_NAME):$(VERSION) terraform apply -state=/tf/plans/terraform.tfstate -refresh=true -backup=/tf/plans/terraform.tfstate.backup 

ip: mkdirs
	$(DOCKER_BIN) run \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PROVISION_OUTPUT):/tf/plans:rw \
		-e "DO_PAT=$(DO_PAT)" \
		-e "DNSIMPLE_EMAIL=$(DNSIMPLE_EMAIL)" \
		-e "DNSIMPLE_API_KEY=$(DNSIMPLE_API_KEY)" \
		-e "SSH_FINGERPRINT=$(CLOUD_SSH_FINGERPRINT)" \
		-it $(NAME)/$(PROJECT_NAME):$(VERSION) terraform output -state=/tf/plans/terraform.tfstate address

destroy:
	$(DOCKER_BIN) run \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PROVISION_OUTPUT):/tf/plans:rw \
		-e "DO_PAT=$(DO_PAT)" \
		-e "DNSIMPLE_EMAIL=$(DNSIMPLE_EMAIL)" \
		-e "DNSIMPLE_API_KEY=$(DNSIMPLE_API_KEY)" \
		-e "SSH_FINGERPRINT=$(CLOUD_SSH_FINGERPRINT)" \
		-it $(NAME)/$(PROJECT_NAME):$(VERSION) teardown.sh 
	rm -rf $(PROVISION_OUTPUT) 

clean: clean_untagged
	rm -rf cloud_provision_base_image 

clean_untagged:
	for i in `docker ps --no-trunc -a -q`;do docker rm $$i;done
	docker images --no-trunc | grep none | awk '{print $$3}' | xargs -r docker rmi

.PHONY: all echo_env check_env prep_docker build clean clean_untagged provision plan destroy mkdirs run
