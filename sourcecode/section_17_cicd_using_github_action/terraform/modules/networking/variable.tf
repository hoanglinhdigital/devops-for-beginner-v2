variable "region" {
  type = string
}

variable "cidr_block" {
  type        = string
  description = "CIDR block của VPC"
  nullable    = false
}

variable "availability_zones" {
  type        = list(string)
  nullable    = false
}

variable "public_subnet_ips" {
  type        = list(string)
  nullable    = false
}
