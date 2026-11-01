variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "image_tag_mutability" {
  type    = string
  default = "MUTABLE"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "force_delete" {
  description = "true = terraform destroy xoa duoc ECR repository ke ca khi con image. Chi bat cho dev/lab."
  type        = bool
  default     = false
}
