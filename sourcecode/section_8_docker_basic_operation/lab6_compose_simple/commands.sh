#!/bin/bash
# Lab 6 – Docker Compose: ứng dụng Node.js đơn giản
cd lab6_compose_simple

# Kiểm tra cú pháp & xem cấu hình sau khi Compose xử lý
docker compose config

# Build image & start service ở chế độ nền
docker compose up -d --build

# Kiểm tra trạng thái & log
docker compose ps
docker compose logs web
docker compose logs -f web

# Truy cập http://localhost:8080 và http://localhost:8080/learning
curl -L http://localhost:8080
curl http://localhost:8080/api/info

# Sửa web/public/index.html (v1.0 -> v1.1), refresh browser để thấy thay đổi ngay (bind mount)
# Sửa web/index.js thì cần restart service
docker compose restart web

# Chạy lệnh bên trong container của service
docker compose exec web sh
# Bên trong container:
ls /app
env | grep APP_VERSION
exit

# Stop / Start (giữ nguyên container)
docker compose stop
docker compose start

# Xoá toàn bộ container, network do Compose tạo
docker compose down
# Xoá cả image đã build
docker compose down --rmi all
