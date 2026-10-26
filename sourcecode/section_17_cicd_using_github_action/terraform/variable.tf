variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "availability_zones" {
  type        = list(string)
  description = "Các Availability Zone sẽ đặt public subnet"
  nullable    = false
}

variable "cidr_block" {
  type        = string
  description = "CIDR block của VPC"
  nullable    = false
}

variable "public_subnet_ips" {
  type        = list(string)
  description = "Danh sách CIDR của public subnet"
  nullable    = false
}

variable "ecr_image_uri" {
  type        = string
  description = "URI image trên ECR dùng cho task definition, ví dụ 123456789012.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:v1.0.0"
  nullable    = false
}

variable "desired_count" {
  type        = number
  description = "Số lượng task ban đầu của mỗi ECS Service (Blue và Green)"
  default     = 2
}
