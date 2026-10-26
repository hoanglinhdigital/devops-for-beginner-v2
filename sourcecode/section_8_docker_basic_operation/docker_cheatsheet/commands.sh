#!/bin/bash
# Docker cheat sheet – các lệnh thường dùng
# Tham khảo thêm: https://docs.docker.com/get-started/docker_cheatsheet.pdf

# ===== Image =====
docker pull <image>:<tag>                    # tải image từ registry
docker images                                # liệt kê image
docker build -t <image>:<tag> .              # build image từ Dockerfile trong thư mục hiện tại
docker build -t <image>:<tag> -f <file> .    # build từ Dockerfile chỉ định
docker tag <image>:<tag> <registry>/<repo>:<tag>
docker push <registry>/<repo>:<tag>          # đẩy image lên registry
docker image history <image>:<tag>           # xem các layer
docker image inspect <image>:<tag>           # xem metadata (Entrypoint, Cmd, Env...)
docker rmi <image>:<tag>                     # xoá image
docker image prune -a                        # xoá toàn bộ image không được container nào dùng

# ===== Container =====
docker run -d -p <host-port>:<container-port> --name <name> <image>:<tag>
docker run -it <image>:<tag> sh              # chạy interactive
docker run --rm <image>:<tag> <command>      # tự xoá container sau khi chạy xong
docker run -e KEY=value <image>:<tag>        # truyền biến môi trường
docker run -v <volume-or-host-path>:<container-path> <image>:<tag>
docker ps                                    # container đang chạy
docker ps -a                                 # tất cả container
docker logs -f <container>                   # xem log
docker exec -it <container> sh               # mở shell trong container đang chạy
docker stop | start | restart <container>
docker rm <container>                        # xoá container đã dừng
docker rm -f <container>                     # xoá cưỡng bức container đang chạy
docker cp <container>:<path> <host-path>     # copy file từ container ra host
docker stats                                 # theo dõi CPU/RAM
docker inspect <container>                   # xem chi tiết (IP, mount, env...)

# ===== Volume & Network =====
docker volume ls
docker volume create <name>
docker volume rm <name>
docker network ls
docker network create <name>
docker network inspect <name>

# ===== Docker Compose =====
docker compose config                        # kiểm tra & hiển thị cấu hình
docker compose up -d                         # tạo & start toàn bộ service
docker compose up -d --build                 # build lại image rồi start
docker compose up -d --scale <service>=3     # chạy 3 replica của service
docker compose ps
docker compose logs -f <service>
docker compose exec <service> sh
docker compose restart <service>
docker compose stop | start
docker compose down                          # xoá container & network
docker compose down -v --rmi local           # xoá cả volume và image đã build

# ===== Dọn dẹp =====
docker system df                             # dung lượng đang dùng
docker system prune                          # xoá container dừng, network không dùng, dangling image, build cache
docker system prune -a --volumes             # xoá TẤT CẢ thứ không dùng (cẩn thận!)
