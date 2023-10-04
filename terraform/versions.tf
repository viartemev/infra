terraform {
  backend "local" {
    path = "terraform-nhl.tfstate"
  }
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  required_version = ">= 0.13"
}

provider "hcloud" {
  token = var.token
}