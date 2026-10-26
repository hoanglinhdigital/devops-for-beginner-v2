#!/bin/bash
# Lab 2 – Thao tác cơ bản với Image & Container
# Tập hợp lệnh tham khảo, copy từng lệnh để chạy.

# ===== Image =====
# Pull image từ Docker Hub (cú pháp: docker pull <image>:<tag>)
docker pull nginx:latest
docker pull ubuntu:24.04
# List image
docker images
# Xem chi tiết & lịch sử layer của image
docker image inspect nginx:latest
docker image history nginx:latest

# ===== Run container =====
# Chạy container nền (-d), mapping port host 8080 -> container 80 (-p), đặt tên (--name)
docker run -d -p 8080:80 --name my-nginx nginx:latest
# Truy cập http://localhost:8080 (hoặc http://<EC2_PUBLIC_IP>:8080)
curl http://localhost:8080

# List container đang chạy
docker ps
# List tất cả container (mọi trạng thái)
docker ps -a

# Xem log của container (-f để theo dõi liên tục, Ctrl+C để thoát)
docker logs my-nginx
docker logs -f my-nginx

# ===== Start / Stop / Restart =====
docker stop my-nginx
docker ps -a
docker start my-nginx
docker restart my-nginx

# ===== Truy cập vào container đang chạy =====
docker exec -it my-nginx /bin/bash
# Bên trong container:
cat /etc/os-release
ls /usr/share/nginx/html
echo "<h1>Hello from container</h1>" > /usr/share/nginx/html/index.html
exit
curl http://localhost:8080

# ===== Container tương tác (-it) =====
# Chạy Ubuntu ở chế độ interactive, gõ exit để thoát (container sẽ dừng)
docker run -it --name my-ubuntu ubuntu:24.04
# Bên trong container:
cat /etc/os-release
exit
docker ps -a

# Chạy nền nhưng vẫn giữ terminal (-dit) để container không bị exit
docker run -dit --name my-ubuntu-bg ubuntu:24.04
docker exec -it my-ubuntu-bg bash
exit

# Container tự xoá sau khi kết thúc (--rm)
docker run --rm ubuntu:24.04 echo "Hello Docker"

# ===== Theo dõi tài nguyên =====
docker stats --no-stream
docker inspect my-nginx

# ===== Xoá container & image =====
docker stop my-nginx
docker rm my-nginx
# Force delete container đang chạy (cẩn thận khi dùng)
docker rm -f my-ubuntu-bg
docker rm my-ubuntu

# Xoá image (theo tên:tag hoặc image id)
docker rmi nginx:latest
docker rmi ubuntu:24.04
docker images

# Dọn dẹp toàn bộ container đã dừng, image không dùng, build cache
docker system df
docker system prune
