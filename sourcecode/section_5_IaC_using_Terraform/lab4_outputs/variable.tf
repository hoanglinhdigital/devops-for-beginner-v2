variable "region" {
  type        = string
  description = "AWS region để deploy resource"
  default     = "ap-southeast-1"
}

variable "environment" {
  type        = string
  description = "Tên môi trường: dev, test hoặc prod"
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment chỉ nhận một trong các giá trị: dev, test, prod."
  }
}

# Map: mỗi môi trường dùng một instance type khác nhau
variable "instance_types" {
  type        = map(string)
  description = "Instance type tương ứng với từng môi trường"
  default = {
    dev  = "t3.micro"
    test = "t3.small"
    prod = "t3.medium"
  }
}

variable "keypair_path" {
  type        = string
  description = "Đường dẫn tới public key"
  default     = "../keypair/udemy-key.pub"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "Dải IP được phép SSH vào EC2"
  default     = "0.0.0.0/0"
}

variable "tags" {
  type        = map(string)
  description = "Tag dùng chung cho resource"
  default     = {}
}
