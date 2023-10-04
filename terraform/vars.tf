variable "token" {
  type = string
  default = ""
}

variable "network" {
  type = map
  default = {
    "name" = "nhl-net"
    "ip_range" = "10.0.0.0/8"
  }
}

variable "subNetwork" {
  type = map
  default = {
    "type" = "cloud"
    "network_zone" = "eu-central"
    "ip_range" = "10.0.1.0/24"
  }
}

variable "instance" {
  type = map(string)
  default = {
      name = "nhl-cap"
      image = "ubuntu-22.04"
      server_type = "cpx11"
      location = "hel1"
      ip_local = "10.0.1.10"
    }
}

variable "labels" {
  type = map
  default = {
    "os" = "ubuntu"
    "http" = ""
    "https" = ""
  }
}