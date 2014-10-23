module "digitalocean" {
    source = "./digitalocean"

    name = "dev-1"
    region = "nyc3"
    do_token = "### DIGITALOCEAN PAT ###"
    key_fingerprint = "### SSH FINGERPRINT ###"
    key_path = "### SSH PRIVATE KEY ###"
    userify_id = "### USERIFY API ID ###"
    userify_key = "### USERIFY API KEY ###"
    dnsimple_email = "### DNSIMPLE EMAIL ###"
    dnsimple_key = "### DNSIMPLE API KEY ###"
}
