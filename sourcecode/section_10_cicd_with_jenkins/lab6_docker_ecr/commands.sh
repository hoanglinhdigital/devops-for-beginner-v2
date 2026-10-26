#!/bin/bash
# Lab 6 – Cài Docker Engine trên Jenkins server & chuẩn bị repository nodejs-random-color
# Hướng dẫn chính thức: https://docs.docker.com/engine/install/ubuntu/

#===Bước 1: Cài Docker Engine + Buildx + Compose plugin (chạy trên EC2, user ubuntu)===
sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#===Bước 2: Cho phép user jenkins (và ubuntu) dùng Docker, restart Jenkins===
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
sudo systemctl restart jenkins
sudo -u jenkins docker version
docker compose version

#===Bước 3: Tạo ECR repository (bỏ qua nếu đã tạo ở Section 9)===
aws ecr create-repository --repository-name nodejs-random-color --region ap-southeast-1
aws ecr describe-repositories --repository-names nodejs-random-color --region ap-southeast-1

#===Bước 4: Fork & clone repository mẫu (chạy trên máy local, thay <your-github-username>)===
# Fork: https://github.com/hoanglinhdigital/nodejs-random-color (branch master)
mkdir -p ~/jenkins-labs
cd ~/jenkins-labs
git clone git@github.com:<your-github-username>/nodejs-random-color.git
cd nodejs-random-color

#===Bước 5: Thay Dockerfile bằng file Dockerfile của lab này rồi push===
git add Dockerfile
git commit -m "build: use node 22 alpine base image from ECR Public"
git push origin master

#===Bước 7: Kiểm tra image trên ECR===
aws ecr list-images --repository-name nodejs-random-color --region ap-southeast-1

#===Troubleshoot: permission denied while trying to connect to the Docker daemon socket===
groups jenkins
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

#===Dọn image trên Jenkins server khi ổ đĩa đầy===
df -h /
sudo docker system df
sudo docker system prune -af
