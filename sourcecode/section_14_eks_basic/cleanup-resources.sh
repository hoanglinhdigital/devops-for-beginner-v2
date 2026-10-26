# Dọn dẹp resource sau chương EKS
# Xoá EKS Cluster:
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1

# Workaround cho lỗi "pods are unevictable".
# Chạy các lệnh sau để xoá các PodDisruptionBudget (PDB) trong cluster:
kubectl get pdb -A
# Xoá các pdb có trong kube-system (thường là coredns và metrics-server):
kubectl delete pdb coredns -n kube-system
kubectl delete pdb metrics-server -n kube-system

# Nếu vẫn không xoá được, thử lại với lệnh:
eksctl delete cluster --name devops-test-cluster --region ap-southeast-1 --disable-nodegroup-eviction

# Kiểm tra thêm và xoá nếu còn:
#   - Load Balancer (ALB/NLB) do AWS Load Balancer Controller tạo
#   - EBS volume còn sót
#   - IAM user developer01 (nếu đã tạo ở Lab 4)
#   - IAM policy AWSLoadBalancerControllerIAMPolicy (nếu không dùng nữa)
#   - ECR repository (nếu không dùng nữa)
