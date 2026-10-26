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
  description = "Image URI ban đầu cho cả 2 môi trường Blue & Green, ví dụ 123456789012.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:v2.0.0"
  nullable    = false
}

variable "desired_count" {
  type        = number
  description = "Số lượng task ban đầu của mỗi ECS Service (Blue và Green)"
  default     = 2
}
