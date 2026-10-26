variable "vpc_id" {
  type     = string
  nullable = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "Danh sách subnet để đặt ALB"
  nullable    = false
}

variable "security_group_ids" {
  type        = list(string)
  description = "Danh sách Security Group gắn vào ALB"
  nullable    = false
}

variable "environments" {
  type        = list(string)
  description = "Tên các môi trường, mỗi môi trường 1 Target Group (blue, green)"
  nullable    = false
}
