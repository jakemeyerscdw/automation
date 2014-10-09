variable "do_token" {
    default = "### DIGITALOCEAN PAT ###"
    value = "### DIGITALOCEAN PAT ###"
}

variable "pub_key" { 
    default = "### SSH PUBLIC KEY ###"
}

variable "pvt_key" {
    default = "### SSH PRIVATE KEY ###"
}

variable "ssh_fingerprint" {
    default = "### SSH FINGERPRINT ###"
}

provider "digitalocean" {
  token = "${var.do_token}"
}
