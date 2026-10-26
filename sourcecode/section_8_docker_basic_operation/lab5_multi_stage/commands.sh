#!/bin/bash
# Lab 5 – Multi-stage Dockerfile
cd lab5_multi_stage

# Build single stage (node:20 + node_modules + source + build output)
docker build -t tmp-nodejs -f Dockerfile-single .

# Build multi-stage (stage 1: node:20 build, stage 2: httpd chứa static file)
docker build -t custom-httpd -f Dockerfile .

# So sánh kích thước: tmp-nodejs > 1GB, custom-httpd ~175MB
docker images tmp-nodejs
docker images custom-httpd

# Xem các file bên trong 2 image
docker run --rm tmp-nodejs ls /app
docker run --rm custom-httpd ls /usr/local/apache2/htdocs

# Chạy image multi-stage
docker run -d -p 8080:80 --name custom-httpd custom-httpd
# Truy cập http://localhost:8080 (hoặc http://<EC2_PUBLIC_IP>:8080)
curl http://localhost:8080

# Chỉ build tới stage 1 (dùng --target)
docker build -t build-only --target buildstep -f Dockerfile .

# Dọn dẹp
docker rm -f custom-httpd
docker rmi tmp-nodejs custom-httpd build-only
docker builder prune -f
