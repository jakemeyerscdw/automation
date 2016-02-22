Cloud Provisioning & Configuration Management
==========

Let's build some automation around the provisioning and configuration of cloud resources.   

### Introduction   
As CDW ramps up its capabilities around all things cloud, one of the first things our 
engineers will need to do is provision cloud infrastructure.   The scripts, templates, code, 
etc. found here are used to automate these tasks.

According to David Cappuccio, vice president and distinguished analyst at Gartner, multi-cloud 
strategies will become common for 70 percent of organizations by 2019.  So while it will be easy 
and sometimes necessary to use tools that aren't truly multi-cloud, generally speaking these tools 
should be avoided.

### Clouds
There's great value in validating our solutions across multiple clouds.  At the same time we don't 
want spend too much time on clouds we're not likely to ever support. The focus for now is on following 
public cloud providers and their [IaaS](http://en.wikipedia.org/wiki/Cloud_computing#Infrastructure_as_a_service) offerings:   
- [x] [Microsoft Azure](https://azure.microsoft.com/en-us/)   
- [x] [Google Cloud Platform](https://cloud.google.com/)    
- [x] [Amazon Web Services](http://aws.amazon.com/)  
- [ ] [DigitalOcean](https://www.digitalocean.com/)   


### The Toolbox  
There is definitely no shortage of tools to choose from.  Honestly, the selection is a bit overwhelming.  Some 
of the tools listed here are very cloud-specific (e.g. Azure-only).  Others pre-date the cloud (e.g. Puppet, Chef, Packer).

#### The Basics  
Every toolbox gotta have at least hammer, hack saw, duck tape and a couple screwdrivers.  
- [x] [Terraform](http://www.terraform.io/)
- [x] [Azure Resource Manager](https://azure.microsoft.com/en-us/documentation/articles/resource-group-overview/)
- [x] [Ansible](http://www.ansible.com/)
- [x] [PowerShell Desired State Configuration](http://technet.microsoft.com/en-us/library/dn249912.aspx)
- [x] [Docker](https://www.docker.com/)   
- [ ] [Vagrant](http://www.vagrantup.com/)   
- [ ] [Packer](https://www.packer.io)   

#### Serious Power Tools
Every carpenter wants that laser-guided miter saw.  These take our solutions to the next level:
- [ ] [Jenkins](https://jenkins-ci.org/)   
- [ ] [Spinnaker](http://spinnaker.io/)   

#### More Basics     
Other tools we may want to consider:
- [ ] [Salt](http://www.saltstack.com/)   
- [ ] [Puppet](http://puppetlabs.com/)   
- [ ] [Chef](https://www.getchef.com/)
