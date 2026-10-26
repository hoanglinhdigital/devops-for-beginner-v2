variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "mongodb_security_group_id" {
  type = string
}

variable "backend_security_group_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "mongodb_volume_size" {
  type = number
}
