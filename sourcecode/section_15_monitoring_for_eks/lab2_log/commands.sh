# Lab 2: Monitoring for Kubernetes – Log (ELK Stack: Elasticsearch + Logstash + Kibana + Filebeat)

#========== Chuẩn bị ==========
# Hoàn thành Lab 1: đã có Minikube + ứng dụng TODO đang chạy trong namespace default.

#========== Bước 1: Deploy stack thu thập log (ELK + Filebeat) ==========
kubectl apply -f log-collection.yaml -n monitoring

#========== Bước 2: Kiểm tra deploy ==========
kubectl get pods -n monitoring
# Kỳ vọng thấy các pod: elasticsearch, kibana, logstash, filebeat ở trạng thái Running,
# cùng với các pod ứng dụng (frontend, backend, mongo).

#========== Bước 3: Truy cập Kibana ==========
minikube service kibana -n monitoring
# Hoặc dùng port-forward:
# kubectl port-forward svc/kibana 5601:5601
# rồi truy cập http://localhost:5601

#========== Bước 4: Tạo Index Pattern & xem log ==========
# 1. Kibana > Stack Management > Index Patterns > Create index pattern
#    - Name: todo-app-logs-*
#    - Time field: @timestamp
# 2. Kibana > Discover, chọn index pattern todo-app-logs-*
# 3. Thao tác với app TODO (thêm/sửa/xoá todo) rồi tìm keyword (VD: DELETE)

#========== Dọn dẹp resource ==========
# Có thể giữ lại để demo/tham khảo. Nếu muốn xoá:
kubectl delete -f log-collection.yaml -n monitoring
