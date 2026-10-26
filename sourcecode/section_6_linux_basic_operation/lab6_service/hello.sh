#!/bin/bash
# Script chạy liên tục, mỗi 5 giây ghi 1 dòng log ra stdout (systemd sẽ đưa vào journal)
while true; do
  echo "Hello from hello.service - $(date '+%Y-%m-%d %H:%M:%S')"
  sleep 5
done
