#!/bin/bash
# Lab 3 – Build & Run container đơn giản với Dockerfile
# Chạy các lệnh trong thư mục lab3_dockerfile (nơi chứa Dockerfile)
cd lab3_dockerfile

# Build image từ Dockerfile trong thư mục hiện tại (.)
docker build -t my-httpd-image:1.0 .
# Kiểm tra image
docker images my-httpd-image
docker image history my-httpd-image:1.0

# Run container, mapping port 8080 của host với port 80 của container
docker run -d -p 8080:80 --name my-httpd-container my-httpd-image:1.0
docker ps

# Kiểm tra trên browser: http://localhost:8080 (hoặc http://<EC2_PUBLIC_IP>:8080)
curl http://localhost:8080
curl http://localhost:8080/version.txt
docker exec my-httpd-container env
docker logs my-httpd-container

# Sửa web/index.html (ví dụ v1.0 -> v2.0), build version mới & chạy lại
docker build -t my-httpd-image:2.0 .
docker rm -f my-httpd-container
docker run -d -p 8080:80 --name my-httpd-container my-httpd-image:2.0
curl http://localhost:8080

# Dọn dẹp
docker stop my-httpd-container
docker rm my-httpd-container
docker rmi my-httpd-image:1.0 my-httpd-image:2.0
