#!/bin/bash
# Lab 1 – Cài đặt Jenkins server trên EC2 (Ubuntu Server 24.04 LTS)
# Tập hợp lệnh tham khảo, copy từng lệnh và chạy trên EC2 sau khi SSH vào (user: ubuntu).
# Hướng dẫn chính thức: https://www.jenkins.io/doc/book/installing/linux/#debianubuntu

#===Bước 1: SSH vào Jenkins server từ máy local (Git Bash / Terminal)===
chmod 400 jenkins-key.pem
ssh -i jenkins-key.pem ubuntu@<jenkins-public-ip>

#===Bước 2: Cập nhật hệ thống & cài Java 21 (JDK – dùng chung cho Jenkins và Maven ở Lab 4)===
sudo apt update
sudo apt install -y fontconfig openjdk-21-jdk
java -version

#===Bước 3: Thêm Jenkins repository (LTS) & cài Jenkins===
# Nếu gặp lỗi NO_PUBKEY: Jenkins định kỳ đổi signing key, mở link hướng dẫn chính thức ở trên để lấy URL key mới nhất.
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins

#===Bước 4: Khởi động Jenkins & bật tự khởi động cùng hệ thống===
sudo systemctl enable --now jenkins
sudo systemctl status jenkins --no-pager
sudo ss -tlnp | grep 8080

#===Bước 5: Lấy mật khẩu admin ban đầu===
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

#===Bước 6: Cài các tool dùng trong CI/CD: Git, unzip, jq, AWS CLI v2===
sudo apt install -y git unzip jq
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip
git --version
jq --version
aws --version

#===Bước 7: Kiểm tra IAM Role đã gắn vào EC2 (user ubuntu và user jenkins)===
aws sts get-caller-identity
sudo -u jenkins aws sts get-caller-identity

#===Troubleshoot: Jenkins không khởi động được===
sudo systemctl status jenkins --no-pager
sudo journalctl -u jenkins -n 100 --no-pager
# Kiểm tra Java mặc định (Jenkins LTS yêu cầu Java 17 hoặc 21)
sudo update-alternatives --config java
sudo systemctl restart jenkins
