#!/bin/bash
# Lab 7 – Docker Compose: Multi container (Node.js + Redis + MySQL)
cd lab7_compose_multi

# Tạo file .env từ file mẫu, sau đó mở .env để đổi password
cp .env.example .env

# Kiểm tra biến trong .env đã được thay vào cấu hình
docker compose config

# Build & start toàn bộ service
docker compose up -d --build

# Theo dõi trạng thái: db chuyển sang (healthy) rồi web mới start
docker compose ps
docker compose logs -f db

# Kiểm tra trên browser: http://localhost:8080
curl http://localhost:8080/api/info
curl http://localhost:8080/api/employees

# Kiểm tra Redis bên trong network của Compose
docker compose exec cache redis-cli GET visits

# Kiểm tra MySQL bằng mysql client trong container (nhập MYSQL_PASSWORD trong .env)
docker compose exec db mysql -uappuser -p testdb -e "SELECT COUNT(*) FROM employee;"

# Kiểm tra network & volume do Compose tạo
docker network ls
docker volume ls
docker compose exec web ping -c 2 db

# Dữ liệu vẫn còn sau khi down (vì dùng named volume)
docker compose down
docker compose up -d
docker compose exec cache redis-cli GET visits
curl http://localhost:8080/api/employees

# Dọn dẹp: xoá container, network, volume (-v) và image đã build
docker compose down -v --rmi local
