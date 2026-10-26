#!/bin/bash
# Lab 8 – Docker Compose: Load Balancer với NGINX
# Nếu lab 7 còn chạy, hãy down trước để giải phóng port 8080
cd lab7_compose_multi
docker compose down
cd ../lab8_compose_load_balancer

# Tạo file .env từ file mẫu, sau đó mở .env để đổi password
cp .env.example .env

# Build & start: 1 nginx + 3 web + 1 redis + 1 mysql
docker compose up -d --build
docker compose ps

# Xem port ngẫu nhiên trên host của từng replica web
docker compose port --index 1 web 3000
docker compose port --index 2 web 3000
docker compose port --index 3 web 3000

# Gửi nhiều request qua NGINX, quan sát hostname thay đổi (round-robin)
# Git Bash / Mac / Linux:
for i in $(seq 1 6); do curl -s http://localhost:8080/api/info; echo; done
# PowerShell:
# 1..6 | ForEach-Object { curl.exe -s http://localhost:8080/api/info; "" }

# Xem header X-Upstream (IP:port của container backend)
curl -s -I http://localhost:8080/api/info

# Đối chiếu IP của các container web
docker compose ps -q web | xargs docker inspect --format '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'

# Scale lên 5 replica, sau đó restart nginx để NGINX resolve lại danh sách IP
docker compose up -d --scale web=5
docker compose restart nginx
for i in $(seq 1 10); do curl -s http://localhost:8080/api/info; echo; done

# Giả lập 1 container bị lỗi: stop 1 replica, NGINX tự chuyển request sang replica khác
docker stop $(docker compose ps -q web | head -n 1)
for i in $(seq 1 6); do curl -s http://localhost:8080/api/info; echo; done

# Log của NGINX
docker compose logs nginx

# Dọn dẹp: xoá container, network, volume và image đã build
docker compose down -v --rmi local
