# Lab 3: Monitoring for Kubernetes – Request Tracing (OpenTelemetry + Jaeger)

#========== Chuẩn bị ==========
# Hoàn thành Lab 1: đã có Minikube + ứng dụng TODO đang chạy trong namespace default.

#========== Bước 1: Cài các Operator cần thiết ==========
# 1. Cài cert-manager (yêu cầu bởi OpenTelemetry Operator)
kubectl apply -f cert-manager.yaml
kubectl get pods -n cert-manager

# 2. Cài Jaeger Operator
kubectl create namespace observability
kubectl apply -f jaeger-operator.yaml -n observability
kubectl get all -n observability
kubectl get pods -n observability

# 3. Đợi cert-manager sẵn sàng (~1 phút) rồi cài OpenTelemetry Operator
kubectl apply -f opentelemetry-operator.yaml
kubectl get all -n opentelemetry-operator-system
kubectl get pods -n opentelemetry-operator-system

#========== Bước 2: Áp dụng cấu hình tracing ==========
kubectl apply -f tracing.yaml
kubectl get pods -n monitoring

#========== Bước 3: Thêm annotation auto-instrument & rollout ==========
# File todo-app-minikube-local-with-mongo-exporter.yaml (trong lab3) đã chứa sẵn annotation:
#   instrumentation.opentelemetry.io/inject-nodejs: "monitoring/nodejs-instrumentation"
kubectl apply -f todo-app-minikube-local-with-mongo-exporter.yaml

kubectl rollout restart deployment/backend-deployment -n default
kubectl rollout restart deployment/frontend-deployment -n default

kubectl rollout status deployment/backend-deployment -n default
kubectl rollout status deployment/frontend-deployment -n default

kubectl get pods
kubectl describe pod <pod-name> -n default

#========== Bước 4: Truy cập Jaeger UI ==========
minikube service jaeger-all-in-one-query -n monitoring

#========== Bước 5: Sinh trace & xem dữ liệu ==========
# 1. Mở app TODO (frontend), tạo/xoá vài todo
# 2. Trong Jaeger UI, mục Service chọn frontend hoặc backend > Find Traces
# 3. Click vào từng trace để xem span chi tiết (thời gian từng service, query Mongo...)

#========== Dọn dẹp resource ==========
kubectl delete -f tracing.yaml
kubectl delete -f opentelemetry-operator.yaml
kubectl delete -f jaeger-operator.yaml -n observability
kubectl delete -f cert-manager.yaml
