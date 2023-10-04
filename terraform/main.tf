module "network" {
  source = "./modules/network"
  network = var.network
  subNetwork = var.subNetwork
}

module "vm" {
  source = "./modules/vm"
  labels = var.labels
  instance = var.instance
  network_id = module.network.network_id
}

output inventory {
  value = module.vm.inventory
}