resource "hcloud_server" "vm" {
  name = var.instance.name
  image = var.instance.image
  server_type = var.instance.server_type
  location = var.instance.location
  delete_protection = true
  rebuild_protection = true
  user_data = file("meta.txt")
  labels = var.labels
}

resource "hcloud_server_network" "network" {
  server_id = hcloud_server.vm.id
  network_id = var.network_id
  ip = var.instance.ip_local
}

