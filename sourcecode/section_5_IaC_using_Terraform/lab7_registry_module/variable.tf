variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "vpc_name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_ips" {
  type        = list(string)
  description = "List of public subnet IPs CIDR"
}

variable "private_subnet_ips" {
  type        = list(string)
  description = "List of private subnet IPs CIDR"
}
