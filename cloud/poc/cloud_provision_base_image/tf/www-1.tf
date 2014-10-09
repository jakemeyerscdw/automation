resource "digitalocean_droplet" "www-1" {
    image = "ubuntu-14-04-x64"
    name = "www-1"
    region = "nyc2"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "f0:a1:87:57:e6:f2:5a:55:e8:d7:26:57:8d:3a:51:99"
    ]
  connection {
      user = "root"
      type = "ssh"
      key_file = "/root/.ssh/id_rsa"
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
