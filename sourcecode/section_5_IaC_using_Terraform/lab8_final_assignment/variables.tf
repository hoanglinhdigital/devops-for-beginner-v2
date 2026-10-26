variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "workstation_ip" {
  type        = string
  description = "Public IP của máy bạn dạng CIDR, ví dụ: 113.161.10.20/32"

  validation {
    condition     = can(cidrhost(var.workstation_ip, 0))
    error_message = "workstation_ip phải là CIDR hợp lệ, ví dụ: 113.161.10.20/32"
  }
}

variable "cidr_block" {
  type        = string
  description = "VPC cidr block. Example: 10.10.0.0/16"
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_ips" {
  type = list(string)
}

variable "private_subnet_ips" {
  type = list(string)
}

variable "keypair_path" {
  type    = string
  default = "../keypair/udemy-key.pub"
}

variable "bastion_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "app_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_instance_type" {
  type    = string
  default = "t3.micro"
}
