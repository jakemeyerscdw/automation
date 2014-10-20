output "ip_address" {
  value = "${digitalocean_droplet.sandbox.ipv4_address}"
}
