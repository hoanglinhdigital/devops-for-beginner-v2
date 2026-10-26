variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t3.micro"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "Name of the keypair to use for the instance"
  nullable    = false
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID để launch EC2. Để null sẽ dùng default subnet"
  default     = null
}

variable "ec2_security_group_ids" {
  type     = list(string)
  nullable = false
}
