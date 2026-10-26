#!/bin/bash
# Script đơn giản ghi log ra file, được cron gọi mỗi phút
LOG_FILE=/home/ec2-user/log.txt

echo "Hello from Cronjob!!! - $(date '+%Y-%m-%d %H:%M:%S') - user: $(whoami)" >> "$LOG_FILE"
