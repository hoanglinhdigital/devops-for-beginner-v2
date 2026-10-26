variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Danh sách subnet để chạy ECS task"
  nullable    = false
}

variable "security_group_ids" {
  type     = list(string)
  nullable = false
}

variable "target_group_arn" {
  type        = string
  description = "ARN của Target Group gắn với ECS Service"
  nullable    = false
}

variable "ecr_image_uri" {
  type        = string
  description = "Image URI ban đầu của container nodejs"
  nullable    = false
}

variable "desired_count" {
  type    = number
  default = 2
}
