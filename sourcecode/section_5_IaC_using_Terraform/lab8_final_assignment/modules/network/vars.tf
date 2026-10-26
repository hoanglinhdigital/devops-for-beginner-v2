variable "availability_zones" {
  type = list(string)
}

variable "cidr_block" {
  type = string
}

variable "public_subnet_ips" {
  type = list(string)
}

variable "private_subnet_ips" {
  type = list(string)
}
