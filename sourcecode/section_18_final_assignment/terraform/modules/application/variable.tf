variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "alb_security_group_id" {
  type = string
}

variable "frontend_security_group_id" {
  type = string
}

variable "backend_security_group_id" {
  type = string
}

variable "mongodb_host" {
  description = "Private IP của máy MongoDB"
  type        = string
}

variable "frontend_ecr_image_uri" {
  type = string
}

variable "backend_ecr_image_uri" {
  type = string
}

variable "frontend_desired_count" {
  type = number
}

variable "backend_desired_count" {
  type = number
}
