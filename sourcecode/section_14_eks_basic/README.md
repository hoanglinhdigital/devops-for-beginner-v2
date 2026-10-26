# Section 14 — Amazon Elastic Kubernetes Service (EKS)

Source code cho các bài lab của chương EKS.

## Cấu trúc thư mục

```
section_14_eks_basic/
├── lab1_create_cluster/
│   ├── cluster-config.yaml   # Cấu hình eksctl tạo cluster + node group
│   └── commands.sh           # Lệnh tạo & kết nối cluster
├── lab2_loadbalancer/
│   ├── iam_policy.json       # IAM policy cho AWS Load Balancer Controller
│   ├── 2048-demo.yaml        # Sample app 2048 game (Part 1)
│   ├── demo-app.yaml         # Frontend/Backend/Mongo + Ingress ALB (Part 2)
│   └── commands.sh           # Lệnh cài ALB Controller + deploy
├── lab3_ebs_volume/
│   ├── storage-class.yaml    # StorageClass EBS (ebs-sc)
│   ├── demo-app.yaml         # StorageClass + PVC + Mongo + app + Ingress
│   └── commands.sh           # Lệnh cài EBS CSI Driver + deploy
├── lab4_rbac/
│   └── commands.sh           # Thêm IAM user vào cluster (RBAC)
└── cleanup-resources.sh      # Dọn dẹp toàn bộ resource
```

## Ghi chú

- Region mặc định: `ap-southeast-1`.
- Tên cluster mặc định: `devops-test-cluster`.
- Thay `<AWS_ACCOUNT_ID>` bằng Account ID thực của bạn trong các lệnh chứa ARN.
- Các file YAML dùng image ECR `devops-lab13-backend`/`devops-lab13-frontend`
  (được build ở Section 13) — thay bằng image của bạn nếu cần.
