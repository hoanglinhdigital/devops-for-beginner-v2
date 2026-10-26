resource "aws_instance" "demo_instance" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.ec2_security_group_ids

  tags = {
    Name = "Udemy Demo"
  }
}

resource "aws_eip" "demo_eip" {
  instance = aws_instance.demo_instance.id
  domain   = "vpc"
}
