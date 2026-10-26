variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "my_ip_cidr" {
  description = "IP công khai của bạn dưới dạng CIDR (vd 1.2.3.4/32), dùng cho bastion SSH"
  type        = string
  default     = "0.0.0.0/0"
}
