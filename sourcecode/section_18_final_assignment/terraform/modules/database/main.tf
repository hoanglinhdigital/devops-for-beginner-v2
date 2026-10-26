# Module database: MongoDB chạy trên EC2 ở private subnet.
# Dùng user_data để cài MongoDB tự động khi instance khởi động lần đầu.
# Trong thực tế có thể dùng Amazon DocumentDB thay vì tự quản lý.

data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

resource "aws_instance" "mongodb" {
  ami                         = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids[0]
  vpc_security_group_ids      = [var.mongodb_security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = false

  root_block_device {
    volume_size = var.mongodb_volume_size
    volume_type = "gp3"
  }

  # Cài MongoDB Community Edition trên Amazon Linux 2023.
  # Trong môi trường production cần cấu hình thêm: auth, bind_ip, backup...
  user_data = <<-EOF
    #!/bin/bash
    set -e
    cat > /etc/yum.repos.d/mongodb-org-7.0.repo <<'REPO'
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
REPO
    dnf install -y mongodb-org
    sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
    systemctl enable --now mongod
  EOF

  tags = { Name = "final-assignment-mongodb" }
}

resource "aws_ebs_volume" "mongodb_data" {
  availability_zone = aws_instance.mongodb.availability_zone
  size              = var.mongodb_volume_size
  type              = "gp3"

  tags = { Name = "final-assignment-mongodb-data" }
}

resource "aws_volume_attachment" "mongodb_data" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.mongodb_data.id
  instance_id = aws_instance.mongodb.id
}
