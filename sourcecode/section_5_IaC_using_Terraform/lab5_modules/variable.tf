variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t3.micro"
  default     = "t3.micro"
}

variable "keypair_path" {
  type    = string
  default = "../keypair/udemy-key.pub"
}
