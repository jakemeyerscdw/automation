# ###-->ZZZ_IMAGE<--###
#
# VERSION     ###-->ZZZ_VERSION<--###
#
# CREATED ON  ###-->ZZZ_DATE<--###

#FROM ###-->ZZZ_BASE_IMAGE<--###
#FROM google/debian:wheezy 
FROM debian:jessie 

MAINTAINER Brad Pinter <brad.pinter@gmail.com>

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y -q \
            curl build-essential ca-certificates git mercurial bzr \
            vim less zip xclip ssh \
            python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools python-pkg-resources python-pip \
            docker.io
RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
RUN mkdir /gopath && \
    mkdir -p /gopath/{'src','bin','pkg'}
RUN mkdir /etc/ansible/
RUN pip install ansible

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN go get -u github.com/mitchellh/gox && \
	git clone https://github.com/mitchellh/goamz.git $GOPATH/src/github.com/mitchellh/goamz && \
	git clone https://github.com/hashicorp/terraform.git $GOPATH/src/github.com/hashicorp/terraform

RUN export XC_ARCH=amd64; export XC_OS=linux; cd $GOPATH/src/github.com/hashicorp/terraform; \
	make updatedeps && make bin

ADD tf /tf
ADD ssh /root/.ssh
RUN chmod 700 /root/.ssh
WORKDIR /tf

CMD ["/bin/bash"]
