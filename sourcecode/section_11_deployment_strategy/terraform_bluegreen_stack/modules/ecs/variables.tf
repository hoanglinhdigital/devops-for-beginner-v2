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

variable "environments" {
  type        = list(string)
  description = "Tên các môi trường, mỗi môi trường 1 ECS Cluster + Service (blue, green)"
  nullable    = false
}

variable "target_group_arns" {
  type        = map(string)
  description = "Map môi trường -> ARN của Target Group, ví dụ { blue = \"arn:...\", green = \"arn:...\" }"
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
