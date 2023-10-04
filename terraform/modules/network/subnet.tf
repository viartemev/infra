resource "hcloud_network_subnet" "subNet" {
  network_id   = hcloud_network.privNet.id
  type         = var.subNetwork.type
  network_zone = var.subNetwork.network_zone
  ip_range     = var.subNetwork.ip_range
}