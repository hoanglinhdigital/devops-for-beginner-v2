resource "aws_instance" "mongo" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  root_block_device {
    volume_size = 10
    encrypted   = true
  }

  # Script cài MongoDB 7.0 và tạo dữ liệu mẫu khi EC2 khởi động lần đầu
  user_data = file("${path.module}/install.sh")

  tags = {
    Name  = "Mongo"
    Owner = "Udemy"
  }
}
