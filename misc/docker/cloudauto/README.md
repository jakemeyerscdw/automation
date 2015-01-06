pinterb/cloudauto
==========

A [Docker](https://www.docker.com) image for acquiring, provisioning, and maintaining cloud infrastructure.

### Introduction 
As CDW labs ramps up its cloud capabilities, one of the first things our engineers will need to do is manage cloud infrastructure.  The Docker imaged provided here provides a way 
to do that in a consistent fashion.  And since it's a container, (nearly) all dependencies are packaged within.


### Clouds
The focus for now is on the following public cloud providers and their [IaaS](http://en.wikipedia.org/wiki/Cloud_computing#Infrastructure_as_a_service) offerings:   
* [DigitalOcean](https://www.digitalocean.com/)   
* [Google Cloud Platform](https://cloud.google.com/)    
* [Microsoft Azure](https://azure.microsoft.com/en-us/)   
* [Amazon Web Services](http://aws.amazon.com/)   


### The Toolbox  
Some of the tools we're using or are considering for use include:
* [Terraform](http://www.terraform.io/)   
* [Ansible](http://www.ansible.com/)   
* [Jsonnet](http://google.github.io/jsonnet/doc/index.html)   


### Using this image



### Building this image
Admittedly the build process for this image is a bit convoluted. But the actual steps involved are quite simple:
````sh
cd into this project's root directory   
./build.sh   
````

Note, to run the build.sh script requires that Docker be installed.  Either natively on Linux or from [boot2docker](http://boot2docker.io) should be sufficient.

If you're wondering why the under-the-covers build process got so wacky it's because it started out with a Makefile.  Make works fine on Linux. But on boot2docker, not so much.  So the quick
and dirty workaround was to package up the Makefile in its own Dockerfile.  Long term, the right thing to do is merge the Makefile into the build.sh script.
 

### Ansible roles   
Like most other configuration management systems, Ansible supports third-party contributions. "[Ansible Galaxy](https://galaxy.ansible.com) jump-starts your automation 
projects with great content from the Ansible community."   

Ansible calls these pre-packaged units of automation [roles](http://docs.ansible.com/playbooks_roles#roles).  This Docker image has been pre-populated with the following roles:   
* ANXS.apt    
* ANXS.bootstraps    
* ANXS.build-essential    
* ANXS.cassandra    
* ANXS.clojure    
* ANXS.cron    
* ANXS.erlang    
* ANXS.fail2ban    
* ANXS.fuse    
* ANXS.generic-directories    
* ANXS.generic-users    
* ANXS.git    
* ANXS.hostname    
* ANXS.logwatch    
* ANXS.monit    
* ANXS.mysql    
* ANXS.nginx    
* ANXS.nodejs    
* ANXS.ntp    
* ANXS.openssh    
* ANXS.oracle-jdk    
* ANXS.perl    
* ANXS.postgresql    
* ANXS.python    
* ANXS.scala    
* ANXS.timezone    
* ANXS.tmpreaper    
* ANXS.utilities    
* ANXS.vim    
* avelis.dome9    
* azavea.apache2    
* azavea.beaver    
* azavea.build-essential    
* azavea.collectd    
* azavea.curator    
* azavea.daemontools    
* azavea.docker    
* azavea.duply    
* azavea.elasticsearch    
* azavea.fig    
* azavea.fpm    
* azavea.git    
* azavea.golang    
* azavea.graphite    
* azavea.hdfs    
* azavea.java    
* azavea.jenkins    
* azavea.kibana    
* azavea.logstash    
* azavea.marathon    
* azavea.memcached    
* azavea.mercurial    
* azavea.mesos    
* azavea.mysql    
* azavea.nginx    
* azavea.nodejs    
* azavea.ntp    
* azavea.packer    
* azavea.pgweb    
* azavea.php-fpm    
* azavea.pip    
* azavea.polipo    
* azavea.postgis    
* azavea.postgresql    
* azavea.postgresql-support    
* azavea.python    
* azavea.redis    
* azavea.relp    
* azavea.ruby    
* azavea.sauce-connect    
* azavea.scala    
* azavea.spark    
* azavea.statsite    
* azavea.unzip    
* azavea.vagrant    
* azavea.virtualbox    
* azavea.virtualenv    
* azavea.zookeeper    
* bakins.datadog    
* franklinkim.htpasswd    
* franklinkim.nginx    
* franklinkim.openssl    
* geerlingguy.daemonize    
* geerlingguy.elasticsearch    
* geerlingguy.elasticsearch-curator    
* geerlingguy.firewall    
* geerlingguy.git    
* geerlingguy.java    
* geerlingguy.kibana    
* geerlingguy.logstash    
* geerlingguy.logstash-forwarder    
* geerlingguy.mailhog    
* geerlingguy.memcached    
* geerlingguy.mysql    
* geerlingguy.nfs    
* geerlingguy.nginx    
* geerlingguy.nodejs    
* geerlingguy.ntp    
* geerlingguy.redis    
* geerlingguy.repo-epel    
* geerlingguy.ruby    
* geerlingguy.security    
* MichaelRigart.fail2ban    
* retr0h.etcd    
* retr0h.logrotate    
* retr0h.nsq    
* savagegus.confd    
* savagegus.consul    
* savagegus.thumbor    
* Stouts.apt    
* Stouts.backup    
* Stouts.celery    
* Stouts.collectd    
* Stouts.deploy    
* Stouts.django    
* Stouts.elasticsearch    
* Stouts.foundation    
* Stouts.grafana    
* Stouts.graphite-api    
* Stouts.graphite-beacon    
* Stouts.hostname    
* Stouts.iptables    
* Stouts.jenkins    
* Stouts.kibana    
* Stouts.limits    
* Stouts.locale    
* Stouts.logstash    
* Stouts.mongodb    
* Stouts.nginx    
* Stouts.nodejs    
* Stouts.notify    
* Stouts.ntp    
* Stouts.openssh    
* Stouts.openvpn    
* Stouts.postfix    
* Stouts.pull    
* Stouts.python    
* Stouts.rabbitmq    
* Stouts.redis    
* Stouts.resources    
* Stouts.ruby    
* Stouts.sentry    
* Stouts.source    
* Stouts.statsd    
* Stouts.sudo    
* Stouts.supervisor    
* Stouts.timezone    
* Stouts.users    
* Stouts.wale    
* Stouts.wsgi    
* tkuhlman.Influxdb    
* tkuhlman.kafka    
* tkuhlman.percona    
* tkuhlman.storm    
* tkuhlman.zookeeper    
* valentinogagliardi.collectd    
* valentinogagliardi.facette    
 

#### NOTES   
System generated on 2015-01-06T14:26:05+0000 
