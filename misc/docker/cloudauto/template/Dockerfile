# ###-->ZZZ_IMAGE<--###
#
# VERSION     ###-->ZZZ_VERSION<--###
#
# CREATED ON  ###-->ZZZ_DATE<--###

FROM ###-->ZZZ_BASE_IMAGE<--###

MAINTAINER Brad Pinter <brad.pinter@gmail.com>

ENV HOME /root
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y -q \
            curl build-essential ca-certificates git mercurial bzr subversion \
            zip unzip vim wget rsync tree less xclip ssh \
            locales \
            python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools python-pkg-resources python-pip && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && \
    echo "en_US.UTF-8" >> /etc/environment && \
    dpkg-reconfigure locales

ENV GO_VERSION 1.3.3
RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
RUN mkdir /gopath && \
    mkdir -p /gopath/{'src','bin','pkg'}

RUN mkdir /etc/ansible/ && touch /etc/ansible/hosts
RUN pip install ansible

### Install some ansbile modules
RUN ansible-galaxy install geerlingguy.firewall && \
    ansible-galaxy install geerlingguy.ntp 

# Add ansible.cfg to $HOME 
ADD ansible.cfg $HOME/.ansible.cfg

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN go get -u github.com/mitchellh/gox && \
	git clone https://github.com/mitchellh/goamz.git $GOPATH/src/github.com/mitchellh/goamz && \
	git clone https://github.com/hashicorp/terraform.git $GOPATH/src/github.com/hashicorp/terraform

RUN export XC_ARCH=amd64; export XC_OS=linux; cd $GOPATH/src/github.com/hashicorp/terraform; \
	make updatedeps && make bin

### Make Debian interactive...
RUN env --unset=DEBIAN_FRONTEND

# Add our provision & teardown scripts to the PATH
ADD scripts /usr/local/bin/ 

ONBUILD ADD tf /tf
ONBUILD ADD ssh /root/.ssh
ONBUILD RUN chmod 700 /root/.ssh

#ONBUILD RUN /usr/local/bin/build.sh --plan
ONBUILD WORKDIR /tf

CMD ["/bin/bash"]
