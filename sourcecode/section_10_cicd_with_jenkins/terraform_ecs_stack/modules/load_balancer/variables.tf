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
