#!/bin/bash
# Lab 1 – Cài đặt Docker & Docker Compose, đăng ký Docker Hub
# Đây là tập hợp lệnh tham khảo, copy từng lệnh để chạy, không chạy cả file một lần.

# ===== Cách 1: Docker Desktop trên Windows / MacOS =====
# Windows: https://docs.docker.com/desktop/setup/install/windows-install/
# MacOS:   https://docs.docker.com/desktop/setup/install/mac-install/
# Sau khi cài xong, mở Docker Desktop, đợi trạng thái "Engine running" rồi kiểm tra:
docker --version
docker compose version
docker info

# ===== Cách 2: EC2 Amazon Linux 2023 (thay thế cho Cloud9) =====
# SSH vào EC2 (xem lại Section 6 – Lab 1)
ssh -i ~/.ssh/docker-lab-key.pem ec2-user@<EC2_PUBLIC_IP>

# Cài Docker Engine
sudo dnf update -y
sudo dnf install -y docker
sudo systemctl enable --now docker
sudo systemctl status docker

# Cho phép ec2-user chạy lệnh docker mà không cần sudo
sudo usermod -aG docker ec2-user
# Thoát SSH và đăng nhập lại để group mới có hiệu lực
exit
ssh -i ~/.ssh/docker-lab-key.pem ec2-user@<EC2_PUBLIC_IP>
groups
docker --version

# Cài Docker Compose plugin (AL2023 không có sẵn package docker-compose-plugin)
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m)" -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
docker compose version

# Cài Docker Buildx plugin (tránh cảnh báo "legacy builder is deprecated")
BUILDX_VERSION=$(curl -s https://api.github.com/repos/docker/buildx/releases/latest | grep '"tag_name"' | cut -d '"' -f 4)
ARCH=$(uname -m | sed 's/x86_64/amd64/; s/aarch64/arm64/')
sudo curl -SL "https://github.com/docker/buildx/releases/download/${BUILDX_VERSION}/buildx-${BUILDX_VERSION}.linux-${ARCH}" -o /usr/local/lib/docker/cli-plugins/docker-buildx
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx
docker buildx version

# Cài Git để clone source code của khoá học
sudo dnf install -y git

# ===== Kiểm tra Docker hoạt động =====
docker run hello-world

# ===== Đăng nhập Docker Hub =====
# Đăng ký tài khoản tại https://hub.docker.com/signup
# Tạo Personal Access Token: Account settings -> Personal access tokens (quyền Read-only là đủ)
docker login -u <DOCKERHUB_USERNAME>
# Nhập Personal Access Token khi được hỏi Password
docker logout
