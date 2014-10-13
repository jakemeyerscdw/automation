resource "digitalocean_droplet" "www-1" {
    image = "ubuntu-14-04-x64"
    name = "dev-1"
    region = "nyc3"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "### SSH FINGERPRINT ###"
    ]
 
  connection {
    user = "root"
    type = "ssh"
    key_file = "### SSH PRIVATE KEY ###"
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }
}

output "address" {
  value = "${digitalocean_droplet.www-1.ipv4_address}"
}
