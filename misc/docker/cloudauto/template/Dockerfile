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
            curl wget build-essential ca-certificates git mercurial bzr subversion \
            zip unzip vim wget rsync tree less xclip ssh \
            locales \
            python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools python-pkg-resources python-pip && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && \
    echo "en_US.UTF-8" >> /etc/environment && \
    dpkg-reconfigure locales


### Install Golang
# Current version information can be found at https://golang.org/dl/
ENV GO_VERSION 1.4.1

RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
RUN mkdir /gopath && \
    mkdir /gopath/src && mkdir /gopath/bin && mkdir /gopath/pkg


### Install Ansible 
# Current version information can be found at https://pypi.python.org/pypi/ansible
ENV ANSIBLE_VERSION 1.8.2

RUN mkdir /etc/ansible/ && touch /etc/ansible/hosts
RUN pip install ansible && \
    pip install azure

# Add ansible.cfg to $HOME 
ADD ansible.cfg $HOME/.ansible.cfg

### Install Ansbile modules (Part 1)
# By Jeff Geerling, author of "Ansible for DevOps"
RUN ansible-galaxy install geerlingguy.firewall && \
    ansible-galaxy install geerlingguy.git && \
    ansible-galaxy install geerlingguy.elasticsearch && \
    ansible-galaxy install geerlingguy.elasticsearch-curator && \
    ansible-galaxy install geerlingguy.kibana && \
    ansible-galaxy install geerlingguy.logstash && \
    ansible-galaxy install geerlingguy.logstash-forwarder && \
    ansible-galaxy install geerlingguy.mailhog && \
    ansible-galaxy install geerlingguy.memcached && \
    ansible-galaxy install geerlingguy.mysql && \
    ansible-galaxy install geerlingguy.nfs && \
    ansible-galaxy install geerlingguy.nginx && \
    ansible-galaxy install geerlingguy.nodejs && \
    ansible-galaxy install geerlingguy.ntp && \
    ansible-galaxy install geerlingguy.redis && \
    ansible-galaxy install geerlingguy.ruby && \
    ansible-galaxy install geerlingguy.security 

### Install Ansbile modules (Part 2)
# By www.azavea.com (https://github.com/azavea?query=ansible)  
RUN ansible-galaxy install azavea.apache2 && \
    ansible-galaxy install azavea.beaver && \
    ansible-galaxy install azavea.build-essential && \
    ansible-galaxy install azavea.collectd && \
    ansible-galaxy install azavea.curator && \
    ansible-galaxy install azavea.daemontools && \
    ansible-galaxy install azavea.docker && \
    ansible-galaxy install azavea.duply && \
    ansible-galaxy install azavea.elasticsearch && \
    ansible-galaxy install azavea.fig && \
    ansible-galaxy install azavea.fpm && \
    ansible-galaxy install azavea.git && \
    ansible-galaxy install azavea.golang && \
    ansible-galaxy install azavea.graphite && \
    ansible-galaxy install azavea.hdfs && \
    ansible-galaxy install azavea.jenkins && \
    ansible-galaxy install azavea.kibana && \
    ansible-galaxy install azavea.logstash && \
    ansible-galaxy install azavea.marathon && \
    ansible-galaxy install azavea.mesos && \
    ansible-galaxy install azavea.mysql && \
    ansible-galaxy install azavea.nodejs && \
    ansible-galaxy install azavea.ntp && \
    ansible-galaxy install azavea.packer && \
    ansible-galaxy install azavea.pgweb && \
    ansible-galaxy install azavea.php-fpm && \
    ansible-galaxy install azavea.polipo && \
    ansible-galaxy install azavea.postgis && \
    ansible-galaxy install azavea.postgresql-support && \
    ansible-galaxy install azavea.redis && \
    ansible-galaxy install azavea.relp && \
    ansible-galaxy install azavea.sauce-connect && \
    ansible-galaxy install azavea.scala && \
    ansible-galaxy install azavea.spark && \
    ansible-galaxy install azavea.statsite && \
    ansible-galaxy install azavea.vagrant && \
    ansible-galaxy install azavea.virtualenv && \
    ansible-galaxy install azavea.zookeeper 

### Install Ansbile modules (Part 3)
# By John Dewey, Cisco (https://github.com/retr0h?query=ansible)  
RUN ansible-galaxy install retr0h.etcd && \
    ansible-galaxy install retr0h.logrotate && \
    ansible-galaxy install retr0h.nsq 

### Install Ansbile modules (Part 4)
# By developer.jivesoftware.com (https://github.com/jivesoftware?query=ansible)  
RUN ansible-galaxy install savagegus.confd && \
    ansible-galaxy install savagegus.consul && \
    ansible-galaxy install savagegus.thumbor

### Install Ansbile modules (Part 5)
# By Tim Kuhlman, HP (https://github.com/tkuhlman)  
RUN ansible-galaxy install tkuhlman.Influxdb && \
    ansible-galaxy install tkuhlman.kafka && \
    ansible-galaxy install tkuhlman.percona && \
    ansible-galaxy install tkuhlman.storm && \
    ansible-galaxy install tkuhlman.zookeeper

### Install Ansbile modules (Part 6)
# By ANXS (https://github.com/ANXS)  
RUN ansible-galaxy install ANXS.apt && \
    ansible-galaxy install ANXS.bootstraps && \
    ansible-galaxy install ANXS.build-essential && \
    ansible-galaxy install ANXS.cassandra && \
    ansible-galaxy install ANXS.clojure && \
    ansible-galaxy install ANXS.cron && \
    ansible-galaxy install ANXS.erlang && \
    ansible-galaxy install ANXS.fail2ban && \
    ansible-galaxy install ANXS.fuse && \
    ansible-galaxy install ANXS.generic-directories && \
    ansible-galaxy install ANXS.generic-users && \
    ansible-galaxy install ANXS.git && \
    ansible-galaxy install ANXS.hostname && \
    ansible-galaxy install ANXS.logwatch && \
    ansible-galaxy install ANXS.monit && \
    ansible-galaxy install ANXS.mysql && \
    ansible-galaxy install ANXS.nginx && \
    ansible-galaxy install ANXS.nodejs && \
    ansible-galaxy install ANXS.ntp && \
    ansible-galaxy install ANXS.openssh && \
    ansible-galaxy install ANXS.postgresql && \
    ansible-galaxy install ANXS.python && \
    ansible-galaxy install ANXS.scala && \
    ansible-galaxy install ANXS.timezone && \
    ansible-galaxy install ANXS.tmpreaper && \
    ansible-galaxy install ANXS.utilities && \
    ansible-galaxy install ANXS.vim 

### Install Ansbile modules (Part 7)
# By Stouts (https://github.com/stouts)  
RUN ansible-galaxy install Stouts.apt && \
    ansible-galaxy install Stouts.backup && \
    ansible-galaxy install Stouts.celery && \
    ansible-galaxy install Stouts.collectd && \
    ansible-galaxy install Stouts.deploy && \
    ansible-galaxy install Stouts.django && \
    ansible-galaxy install Stouts.elasticsearch && \
    ansible-galaxy install Stouts.foundation && \
    ansible-galaxy install Stouts.grafana && \
    ansible-galaxy install Stouts.graphite-api && \
    ansible-galaxy install Stouts.graphite-beacon && \
    ansible-galaxy install Stouts.iptables && \
    ansible-galaxy install Stouts.jenkins && \
    ansible-galaxy install Stouts.kibana && \
    ansible-galaxy install Stouts.limits && \
    ansible-galaxy install Stouts.logstash && \
    ansible-galaxy install Stouts.mongodb && \
    ansible-galaxy install Stouts.nodejs && \
    ansible-galaxy install Stouts.notify && \
    ansible-galaxy install Stouts.openssh && \
    ansible-galaxy install Stouts.openvpn && \
    ansible-galaxy install Stouts.postfix && \
    ansible-galaxy install Stouts.pull && \
    ansible-galaxy install Stouts.rabbitmq && \
    ansible-galaxy install Stouts.redis && \
    ansible-galaxy install Stouts.resources && \
    ansible-galaxy install Stouts.ruby && \
    ansible-galaxy install Stouts.sentry && \
    ansible-galaxy install Stouts.source && \
    ansible-galaxy install Stouts.statsd && \
    ansible-galaxy install Stouts.supervisor && \
    ansible-galaxy install Stouts.wale

### Install Ansbile modules (Part ??)
# Misc. monitoring  
RUN ansible-galaxy install valentinogagliardi.collectd && \
    ansible-galaxy install bakins.datadog && \
    ansible-galaxy install avelis.dome9 && \
    ansible-galaxy install valentinogagliardi.facette && \
    ansible-galaxy install MichaelRigart.fail2ban 

### Install Ansbile modules (Part ??)
# Couchbase & Aerospike 
RUN ansible-galaxy install couchbase.couchbase-server && \
    ansible-galaxy install pioho07.aerospike
 
### Install Ansbile modules (Part ??)
# Couchbase & Aerospike 
RUN ansible-galaxy install playlist.go && \
    ansible-galaxy install playlist.nodejs && \
    ansible-galaxy install playlist.nsq && \
    ansible-galaxy install playlist.pm2 && \
    ansible-galaxy install playlist.python && \
    ansible-galaxy install playlist.redis && \
    ansible-galaxy install playlist.rethinkdb && \
    ansible-galaxy install playlist.roshi

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin


### Install Terraform 
# Current version information can be found at https://github.com/terraform/blob/master/version.go
ENV TERRAFORM_VERSION "0.3.7 dev" 

RUN git clone https://github.com/hashicorp/terraform.git $GOPATH/src/github.com/hashicorp/terraform && \
    cd $GOPATH/src/github.com/hashicorp/terraform && \
    make updatedeps && go get github.com/hashicorp/terraform/terraform && \ 
    make dev


### Install Jsonnet
# Current version information can be found at https://github.com/jsonnet/blob/master/jsonnet.cpp
ENV JSONNET_VERSION "v0.6.0-beta" 

RUN cd /opt && git clone https://github.com/google/jsonnet.git && \
    cd jsonnet && make 

ENV PATH $PATH:/opt/jsonnet


### Add templates 
RUN mkdir /opt/templates
ADD templates /opt/templates/

### Make Debian interactive...
RUN env --unset=DEBIAN_FRONTEND

# Add our provision & teardown scripts to the PATH
ADD scripts /usr/local/bin/ 

VOLUME ["/data"]

ONBUILD ADD tf /tf
ONBUILD ADD ssh /root/.ssh
ONBUILD RUN chmod 700 /root/.ssh

#ONBUILD RUN /usr/local/bin/build.sh --plan
ONBUILD WORKDIR /tf

CMD ["/bin/bash"]
