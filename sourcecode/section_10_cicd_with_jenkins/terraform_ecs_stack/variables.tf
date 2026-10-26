variable "region" {
  type    = string
  default = "ap-southeast-1"
}

#==========Networking===================
variable "availability_zones" {
  type     = list(string)
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

#==========ECS==========================
variable "ecr_image_uri" {
  type        = string
  description = "Image URI trên ECR (kết quả của Lab 6), ví dụ 123456789012.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:ver-1"
  nullable    = false
}

variable "desired_count" {
  type        = number
  description = "Số lượng task của ECS Service"
  default     = 2
}
