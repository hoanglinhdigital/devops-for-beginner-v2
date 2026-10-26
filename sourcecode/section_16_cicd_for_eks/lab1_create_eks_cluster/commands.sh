# Lab 1: Tạo một EKS Cluster và kết nối tới nó.

#========== Phương án sử dụng AWS Console ==========
# Tham khảo guide chính thức:
# https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html

#========== Phương án sử dụng EKSCTL ==========
# Guide gốc của AWS:
# https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

# Yêu cầu máy đã cài sẵn các tool (nên dùng chocolatey để cài eksctl/kubectl/helm cho Windows):
#  - aws cli   (chú ý không dùng version quá cũ)
#  - kubectl   https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
#  - eksctl    https://eksctl.io/installation/
#  - helm      https://helm.sh/docs/intro/install/

# Kiểm tra version
aws --version
kubectl version --client
eksctl version
helm version --short

#=== Step 1: Kiểm tra IAM user đã có quyền tạo EKS Cluster ===
aws sts get-caller-identity

#=== Step 2: Tạo EKS Cluster (mất ~10 phút) ===
# Chỉnh sửa cluster-config.yaml nếu muốn đổi tên cluster, region, số node, instance type...
eksctl create cluster -f cluster-config.yaml

# Disable extended support cho EKS (giúp tiết kiệm chi phí):
aws eks update-cluster-config --name devops-test-cluster --upgrade-policy supportType=STANDARD

#=== Step 3: Cập nhật kubeconfig (Windows: C:\Users\{username}\.kube\config) ===
aws eks update-kubeconfig --region ap-southeast-1 --name devops-test-cluster

# Kiểm tra context
kubectl config get-contexts
# [Optional] chuyển context nếu có nhiều cluster
kubectl config use-context devops-test-cluster

# Xem thông tin cluster
kubectl cluster-info

#=== Step 4: Đợi ~5 phút rồi kiểm tra node ===
kubectl get nodes

#=== Step 5: Cài OIDC provider cho cluster ===
# Tham khảo:
# https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html

# Lấy OIDC ID của cluster
oidc_id=$(aws eks describe-cluster --name devops-test-cluster --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
echo $oidc_id

#=== Step 6: Cài đặt AWS Load Balancer Controller (tạo ALB/NLB từ Ingress/Service) ===
# Tham khảo:
# https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

# 1) Tạo IAM policy cho LB Controller (dùng file iam_policy.json kèm theo)
aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json

# 2) Tạo IRSA (IAM Role for Service Account) cho LB Controller
eksctl create iamserviceaccount \
  --cluster=devops-test-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::<AWS_ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --region ap-southeast-1 \
  --approve

# 3) Cài LB Controller bằng Helm
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=devops-test-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --version 1.14.0

# 4) Apply ứng dụng mẫu (2048 game) để kiểm tra ALB
# https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html#application-load-balancer-sample-application
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.14.1/docs/examples/2048/2048_full.yaml

# Kiểm tra ALB được tạo ra và truy cập thử game 2048 qua DNS của ALB (thêm http:// trước DNS)

# Xoá ứng dụng 2048 sau khi kiểm tra xong
kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.14.1/docs/examples/2048/2048_full.yaml

#=== Step 7: Cài EBS CSI Driver (Storage cho PVC, dùng cho MongoDB ở Lab 2/3/4) ===
# 1) Tạo IAM Role cho EBS CSI Driver
eksctl create iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster devops-test-cluster \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --role-only \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve

# Đợi khoảng 3 phút để role được tạo, sau đó cài add-on (thay <AWS_ACCOUNT_ID> = Account ID của bạn)
eksctl create addon \
  --name aws-ebs-csi-driver \
  --cluster devops-test-cluster \
  --service-account-role-arn arn:aws:iam::<AWS_ACCOUNT_ID>:role/AmazonEKS_EBS_CSI_DriverRole \
  --force

# Kết thúc: cluster đã sẵn sàng (node group healthy, ALB Controller + EBS CSI Driver đã cài)
