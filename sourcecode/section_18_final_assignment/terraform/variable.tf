variable "region" {
  description = "AWS region để triển khai"
  type        = string
  default     = "ap-southeast-1"
}

variable "availability_zones" {
  description = "2 Availability Zone dùng cho VPC"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "cidr_block" {
  description = "CIDR block của VPC"
  type        = string
  default     = "10.18.0.0/16"
}

variable "public_subnet_ips" {
  description = "CIDR của các public subnet (theo thứ tự AZ)"
  type        = list(string)
  default     = ["10.18.1.0/24", "10.18.2.0/24"]
}

variable "private_subnet_ips" {
  description = "CIDR của các private subnet (theo thứ tự AZ)"
  type        = list(string)
  default     = ["10.18.3.0/24", "10.18.4.0/24"]
}

variable "my_ip_cidr" {
  description = "IP công khai của bạn dạng CIDR, dùng để mở SSH cho bastion (vd 203.0.113.10/32)"
  type        = string
}

variable "key_name" {
  description = "Tên EC2 key pair dùng để SSH vào máy MongoDB (nếu cần)"
  type        = string
}

variable "mongodb_instance_type" {
  description = "Instance type cho máy chạy MongoDB"
  type        = string
  default     = "t3.medium"
}

variable "mongodb_volume_size" {
  description = "Dung lượng (GiB) EBS volume lưu data của MongoDB"
  type        = number
  default     = 20
}

variable "frontend_image_tag" {
  description = "Tag của Docker image frontend trên ECR"
  type        = string
  default     = "latest"
}

variable "backend_image_tag" {
  description = "Tag của Docker image backend trên ECR"
  type        = string
  default     = "latest"
}

variable "frontend_desired_count" {
  description = "Số task frontend mong muốn"
  type        = number
  default     = 2
}

variable "backend_desired_count" {
  description = "Số task backend mong muốn"
  type        = number
  default     = 2
}
