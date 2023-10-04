variable "network" {
  type = map
  default = {
    "name" = ""
    "ip_range" = ""
  }
}

variable "subNetwork" {
  type = map
  default = {
    "type" = ""
    "network_zone" = ""
    "ip_range" = ""
  }
}