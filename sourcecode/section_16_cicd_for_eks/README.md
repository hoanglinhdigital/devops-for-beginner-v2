# Section 16 — CICD for Kubernetes/EKS

Source code cho các bài lab của chương CI/CD cho Kubernetes & EKS.

## Cấu trúc thư mục

```
section_16_cicd_for_eks/
├── lab1_create_eks_cluster/
│   ├── cluster-config.yaml    # Cấu hình eksctl tạo cluster + node group
│   ├── iam_policy.json        # IAM policy cho AWS Load Balancer Controller
│   └── commands.sh            # Lệnh tạo cluster, cài OIDC/ALB Controller/EBS CSI
├── lab2_cicd_codepipeline/
│   ├── buildspec.yml          # Build stage: build Docker image + push ECR
│   ├── buildspec-deploy.yml   # Deploy stage (kubectl apply) - phương án CodeBuild
│   ├── aws-eks.yaml           # Manifest deploy frontend/backend/mongo + Ingress ALB
│   └── commands.sh            # Lệnh tạo access entry, gán policy cho CodePipeline
├── lab3_cicd_github_action/
│   ├── deploy.yml             # GitHub Actions workflow build + push ECR + deploy EKS
│   ├── aws-eks.yaml           # Manifest deploy (giống lab2)
│   └── commands.sh            # Lệnh tạo repo, cấu hình secret, trigger workflow
├── lab4_gitops_argocd/
│   ├── deploy.yml             # GitHub Actions workflow (manual + build/push ECR)
│   ├── argocd-app.yaml        # ArgoCD Application trỏ tới manifest repository
│   └── commands.sh            # Lệnh cài ArgoCD, tạo application, sync
└── clear-resources.sh         # Dọn dẹp toàn bộ resource
```

## Ghi chú

- Region mặc định: `ap-southeast-1`.
- Tên cluster mặc định: `devops-test-cluster`.
- Ứng dụng mẫu (monorepo frontend + backend + MongoDB):
  `https://github.com/hoanglinhdigital/react-express-mongodb`.
- Thay `<AWS_ACCOUNT_ID>` bằng Account ID thực của bạn trong các file YAML/lệnh chứa ARN.
- Các file YAML deploy dùng image ECR `todo-app-backend`/`todo-app-frontend`.
