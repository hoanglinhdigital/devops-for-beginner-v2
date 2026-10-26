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
  description = "Image URI trên ECR (kết quả của Lab 4), ví dụ 123456789012.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:latest"
  nullable    = false
}

variable "desired_count" {
  type        = number
  description = "Số lượng task của ECS Service"
  default     = 2
}

variable "deployment_controller_type" {
  type        = string
  description = "ECS (Lab 6 – rolling update) hoặc CODE_DEPLOY (Lab 7, Lab 8 – Blue/Green, Canary)"
  default     = "ECS"

  validation {
    condition     = contains(["ECS", "CODE_DEPLOY"], var.deployment_controller_type)
    error_message = "deployment_controller_type chỉ nhận giá trị ECS hoặc CODE_DEPLOY."
  }
}
