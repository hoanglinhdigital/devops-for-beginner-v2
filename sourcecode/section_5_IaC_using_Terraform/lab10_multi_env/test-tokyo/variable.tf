variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "name_prefix" {
  type    = string
  default = "udemy"
}

# Parameters for networking module
variable "availability_zone_1" {
  type     = string
  nullable = false
}

variable "availability_zone_2" {
  type     = string
  nullable = false
}

variable "cidr_block" {
  type     = string
  nullable = false
}

variable "public_subnet_ips" {
  type     = list(string)
  nullable = false
}

variable "private_subnet_ips" {
  type     = list(string)
  nullable = false
}

# Parameters for compute module
variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t3.micro"
  default     = "t3.micro"
}

variable "keypair_path" {
  type    = string
  default = "../../keypair/udemy-key.pub"
}
