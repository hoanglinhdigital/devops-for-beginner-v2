#!/bin/bash
# Lab 4 – Phân biệt CMD và ENTRYPOINT
cd lab4_cmd_entrypoint

# Inspect image alpine, chú ý mục "Entrypoint" và "Cmd"
docker pull alpine:latest
docker image inspect alpine:latest --format 'Entrypoint={{json .Config.Entrypoint}} Cmd={{json .Config.Cmd}}'

# ======= Dockerfile-1: ENTRYPOINT ["ls"] =======
docker build -t alpine-1 -f Dockerfile-1 .
docker image inspect alpine-1 --format 'Entrypoint={{json .Config.Entrypoint}} Cmd={{json .Config.Cmd}}'
# Không truyền param => chạy "ls"
docker run --rm alpine-1
# Truyền param "-alh" => chạy "ls -alh"
docker run --rm alpine-1 -alh

# ======= Dockerfile-2: CMD ["ls"] =======
docker build -t alpine-2 -f Dockerfile-2 .
docker image inspect alpine-2 --format 'Entrypoint={{json .Config.Entrypoint}} Cmd={{json .Config.Cmd}}'
# Không truyền param => chạy "ls"
docker run --rm alpine-2
# Truyền param "-alh" => GHI ĐÈ CMD, Docker chạy "-alh" => LỖI
docker run --rm alpine-2 -alh
# Muốn chạy "ls -alh" phải truyền đầy đủ lệnh
docker run --rm alpine-2 ls -alh

# ======= Dockerfile-3: ENTRYPOINT ["ls"] + CMD ["-alh"] =======
docker build -t alpine-3 -f Dockerfile-3 .
docker image inspect alpine-3 --format 'Entrypoint={{json .Config.Entrypoint}} Cmd={{json .Config.Cmd}}'
# Không truyền param => chạy "ls -alh"
docker run --rm alpine-3
# Truyền param => thay thế CMD, chạy "ls -p --full-time"
docker run --rm alpine-3 -p --full-time

# Ghi đè ENTRYPOINT lúc run
docker run --rm --entrypoint echo alpine-3 "Hello from new entrypoint"

# Dọn dẹp
docker rmi alpine-1 alpine-2 alpine-3
