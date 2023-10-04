variable "labels" {
  type = map
  default = {}
}

variable "network_id" {
  type = string
  default = ""
}

variable "instance" {
  type = map(string)
  default = {}
}