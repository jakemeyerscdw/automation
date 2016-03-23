#--------------------------------------------------------------
# This is an example of Terraform's configuration syntax
#--------------------------------------------------------------

variable "my_domain"   { default = "cloudutils.io" }

# Create a new Web droplet in the nyc2 region
resource "digitalocean_droplet" "web" {
  name = "web-1"
  image = "ubuntu-14-04-x64"
  size = "512mb"
  region = "nyc2"
}

# Add a record to the domain
resource "dnsimple_record" "hello" {
  domain = "${var.my_domain}"
  name = "terraform"
  value = "${digitalocean_droplet.web.ipv4_address}"
  type = "A"
  ttl = 3600
}
