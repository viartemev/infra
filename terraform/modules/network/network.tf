resource "hcloud_network" "privNet" {
  name     = var.network.name
  ip_range = var.network.ip_range
  delete_protection = true
}