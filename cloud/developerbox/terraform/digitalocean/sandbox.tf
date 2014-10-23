resource "digitalocean_droplet" "sandbox" {
    image = "${lookup(var.image, var.region)}"
    name = "${var.name}"
    region = "${var.region}"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "${var.key_fingerprint}"
    ]
#    user_data = ${file("${path.module}/scripts/example.tf")}
 
  connection {
    user = "root"
    type = "ssh"
    key_file = "${var.key_path}"
    timeout = "2m"
  }

  provisioner "local-exec" {
      command = "echo \"Host ${digitalocean_droplet.sandbox.ipv4_address}\" >> ~/.ssh/config && echo \"   StrictHostKeyChecking no\" >> ~/.ssh/config && echo \"   UserKnownHostsFile=/dev/null\"  >> ~/.ssh/config"
  }

#  provisioner "remote-exec" {
#      scripts = [
#          "${path.module}/scripts/userify.sh"
#      ]
#  }

  provisioner "remote-exec" {
      inline = [
          "mkdir -p /etc/ansible/facts.d"
      ]
  }

#  provisioner "remote-exec" {
#      inline = [
#          "curl -k \"https://shim.userify.com/installer.sh\" | api_id=\"${var.userify_id}\" api_key=\"${var.userify_key}\" sudo -sE"
#      ]
#  }

#          "killall shim.py shim.sh 2>/dev/null",
#  provisioner "remote-exec" {
#      inline = [
#          "echo \"Launching shim.sh...\"",
#          "/opt/userify/shim.sh &",
#          "ps auxwwwww | grep shim"
#      ]
#  }

  provisioner "local-exec" {
      command = "echo [sandbox] > /etc/ansible/hosts && echo ${digitalocean_droplet.sandbox.ipv4_address} >> /etc/ansible/hosts"
  }

  provisioner "local-exec" {
      command = "ansible-playbook ${path.module}/ansible/site.yml --extra-vars \"userify_api_id=${var.userify_id} userify_api_key=${var.userify_key}\" -vvvv"
  }

}
