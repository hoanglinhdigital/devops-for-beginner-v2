# Lab 1: Monitoring for Kubernetes – Metrics and Alert (Prometheus + Grafana + AlertManager)

#========== Chuẩn bị môi trường ==========
# Yêu cầu máy local đã cài: Docker Desktop, Minikube, kubectl.
# Nếu chưa có: https://minikube.sigs.k8s.io/docs/start/

# Kiểm tra version
minikube update-check
kubectl version --client

# Cập nhật Minikube (nếu cần)
minikube stop
minikube delete
choco upgrade minikube
minikube start

#========== Bước 1: Deploy ứng dụng TODO lên Minikube ==========
# Source: https://github.com/hoanglinhdigital/react-express-mongodb
# Lưu ý: dùng file todo-app-minikube-local-with-mongo-exporter.yaml (đã có trong thư mục lab1)

kubectl apply -f todo-app-minikube-local-with-mongo-exporter.yaml
kubectl get pods
kubectl get services

#========== Bước 2: Deploy Monitoring Stack (Prometheus + Grafana + AlertManager) ==========
kubectl apply -f todo-app-monitoring-stack.yaml

# Kiểm tra kết quả deploy
kubectl get pods -n monitoring
kubectl get services -n monitoring
kubectl get deployments -n monitoring

#========== Bước 3: Truy cập các service ==========
# Mở Grafana (user/pass: admin/admin)
minikube service grafana -n monitoring

# Mở Prometheus UI
minikube service prometheus -n monitoring

# Mở AlertManager UI
minikube service alertmanager -n monitoring

#========== Bước 4: Cấu hình Alert Rules ==========
kubectl apply -f alert-rules.yaml

# Mở todo-app-monitoring-stack.yaml, bỏ comment dòng 113 và 130 (mount alert_rules.yml)
# rồi apply lại:
kubectl apply -f todo-app-monitoring-stack.yaml

# Kiểm tra Prometheus Alerts tab: 5 alert (BackendPodDown, FrontendPodDown,
# MongoPodDown, HighCPUUsage, HighMemoryUsage) ở trạng thái Inactive.

#========== Bước 5 (Tuỳ chọn): Cấu hình Slack Notification ==========
# 1. Tạo Slack Incoming Webhook (Settings & administration > Manage apps)
# 2. Sửa alert-manager-configmap-for-slack.yaml: điền webhook URL + channel
# 3. Copy nội dung ConfigMap đó vào todo-app-monitoring-stack.yaml (thay block AlertManager ConfigMap)
kubectl apply -f todo-app-monitoring-stack.yaml
kubectl rollout restart deployment alertmanager -n monitoring

#========== Test Alert ==========
# Scale backend về 0 để kích hoạt alert BackendPodDown
kubectl scale deployment backend-deployment --replicas=0 -n default
# Đợi ~1 phút, quan sát Prometheus Alerts chuyển sang Firing, AlertManager nhận alert,
# Slack nhận notification. Sau đó scale lại:
kubectl scale deployment backend-deployment --replicas=2 -n default

#========== Dọn dẹp resource ==========
kubectl delete -f todo-app-monitoring-stack.yaml
kubectl delete -f todo-app-minikube-local-with-mongo-exporter.yaml
