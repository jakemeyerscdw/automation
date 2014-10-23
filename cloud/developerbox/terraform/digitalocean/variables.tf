variable "image" {
    default = {
        sfo1 = "ubuntu-14-04-x64"
        nyc2 = "ubuntu-14-04-x64"
        nyc3 = "ubuntu-14-04-x64"
        ams2 = "ubuntu-14-04-x64"
        sgp1 = "ubuntu-14-04-x64"
        lon1 = "ubuntu-14-04-x64"
        ams3 = "ubuntu-14-04-x64"
    }
}

variable "region" {
    default = "nyc3"
    description = "The region of DigitalOcean."
}

variable "do_token" {
    description = "The DigitalOcean Personal Access Token used to connect to DigitalOcean remotely."
}

variable "name" {
    default = "dev-1"
    description = "The name of the Droplet."
}

variable "key_fingerprint" {
    description = "The ssh fingerprint of the public key the droplet will be configured with."
}

variable "key_path" {
    description = "The ssh key file used by Terraform to connect to its newly created resource."
}

variable "dnsimple_email" {
    description = "The DNSimple email address that identifies your account."
}

variable "dnsimple_key" {
    description = "The DNSimple API key."
}

variable "userify_id" {
    description = "The Userify API id."
}

variable "userify_key" {
    description = "The Userify API key."
}
