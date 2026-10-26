#!/bin/bash
# Lab 5 – Cài Node.js 22 LTS trên Jenkins server (chạy trên EC2, user ubuntu)
# Hướng dẫn chính thức NodeSource: https://github.com/nodesource/distributions

curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt install -y nodejs
rm nodesource_setup.sh
node --version
npm --version

#===(Tuỳ chọn) Phần 3: Kiểm tra website tĩnh trên S3 (chạy trên máy local)===
# Thay <your-suffix> bằng hậu tố bucket web hosting của bạn
aws s3 ls s3://jenkins-web-<your-suffix>/
curl -I http://jenkins-web-<your-suffix>.s3-website-ap-southeast-1.amazonaws.com
