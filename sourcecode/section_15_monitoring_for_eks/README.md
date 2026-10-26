# Section 15 — Monitoring for Kubernetes/EKS

Source code cho các bài lab về Monitoring & Observability trên Kubernetes/EKS.

## Cấu trúc thư mục

```
section_15_monitoring_for_eks/
├── lab1_metrics_alert/
│   ├── todo-app-minikube-local-with-mongo-exporter.yaml  # Ứng dụng TODO (frontend/backend/mongo + mongo-exporter)
│   ├── todo-app-monitoring-stack.yaml                    # Prometheus + Grafana + AlertManager
│   ├── alert-rules.yaml                                  # 5 alert rules (pod down, CPU/Memory cao)
│   ├── alert-manager-configmap-for-slack.yaml            # Cấu hình AlertManager gửi Slack
│   └── prometheus_query.md                               # Các PromQL mẫu
├── lab2_log/
│   ├── log-collection.yaml                               # Elasticsearch + Logstash + Kibana + Filebeat
│   └── diagram.mermaid                                   # Sơ đồ luồng thu thập log
└── lab3_request_tracing/
    ├── cert-manager.yaml                                 # cert-manager (yêu cầu bởi OTel Operator)
    ├── jaeger-operator.yaml                              # Jaeger Operator
    ├── opentelemetry-operator.yaml                       # OpenTelemetry Operator
    ├── tracing.yaml                                      # Jaeger All-in-one + Instrumentation + OTel Collector
    └── todo-app-minikube-local-with-mongo-exporter.yaml  # App TODO + annotation auto-instrument
```

## Ghi chú

- Môi trường thực hành: **Minikube** trên máy local (không dùng AWS/EKS).
- Ứng dụng TODO được deploy từ repository
  `https://github.com/hoanglinhdigital/react-express-mongodb` (theo hướng dẫn của Lab 1).
- Tất cả resource monitoring nằm trong namespace `monitoring`.
- Thay `<Replace with your own>` trong `alert-manager-configmap-for-slack.yaml`
  bằng Slack webhook URL và tên channel thực của bạn.
