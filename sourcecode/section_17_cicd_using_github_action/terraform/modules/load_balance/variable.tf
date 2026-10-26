variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where ALB and Target Group live"
  nullable    = false
}

variable "load_balance_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs to launch Application Load Balancer"
  nullable    = false
}

variable "load_balance_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs applied to Application Load Balancer"
  nullable    = false
}
