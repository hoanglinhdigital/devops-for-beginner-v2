#!/usr/bin/env bash
# Goi API login cua app moi 1 giay de do downtime khi switchover RDS Blue/Green
# hoac khi CodeDeploy reroute traffic ECS Blue/Green.
# Moi lan login thanh cong, app doc bang `user` va GHI 1 dong vao bang `session`
# -> kiem tra duoc ca doc lan ghi xuong database.
#
# Cach dung (Git Bash / Linux / macOS):
#   bash check_downtime.sh <ALB_DNS_NAME>
# Vi du:
#   bash check_downtime.sh expense-mgmt-dev-alb-01-123456789.ap-southeast-1.elb.amazonaws.com
# Dung script: Ctrl + C

ALB_DNS="$1"
EMAIL="${EMAIL:-demo@example.com}"
PASSWORD="${PASSWORD:-password123}"

if [ -z "$ALB_DNS" ]; then
  echo "Thieu tham so ALB_DNS_NAME. Vi du: bash check_downtime.sh my-alb-123.ap-southeast-1.elb.amazonaws.com"
  exit 1
fi

ok=0
fail=0

trap 'echo; echo "Tong ket: OK=$ok  FAIL=$fail"; exit 0' INT

while true; do
  code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 \
    -X POST "http://$ALB_DNS/api/auth/login" \
    -H "Content-Type: application/json" \
    -d "{\"email\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")

  if [ "$code" = "200" ]; then
    ok=$((ok + 1))
    echo "$(date '+%H:%M:%S')  HTTP $code  OK"
  else
    fail=$((fail + 1))
    echo "$(date '+%H:%M:%S')  HTTP $code  <-- FAIL"
  fi

  sleep 1
done
