## Deploy a Best Practices Infrastructure in Microsoft Azure

This project will deploy an end-to-end infrastructure in Azure that includes the below resources in `us-central`.

- Misc.
  - Storage account
  - Resource group
  - Availability sets
- Network
  - Public IP addresses
  - Network security groups
  - Virtual networks
  - Private subnets
  - Network interfaces
  - Load balancers
- Data
  - Consul or etcd cluster for distibuted computing
  - Vault HA with Consul backend
- Compute
  - NATS for messaging
  - HAProxy or Traefik for load balancing
- DNS

### Setup
