# Lab 2: Implement CICD sử dụng AWS CodePipeline (CodeCommit + CodeBuild + EKS).

# Repository ứng dụng (monorepo frontend + backend + MongoDB):
# https://github.com/hoanglinhdigital/react-express-mongodb

#==== Step 1: Source Control với AWS CodeCommit =====
# Tạo repository tên todo-app-monorepo trên CodeCommit, sau đó clone về local:
git clone https://git-codecommit.<region>.amazonaws.com/v1/repos/todo-app-monorepo

# Copy toàn bộ code (frontend/, backend/, aws-eks.yaml) vào repo vừa clone rồi push:
git add .
git commit -m "Initial commit for EKS deployment"
git push origin master

#==== Step 2: Tạo 2 ECR repository =====
# Tạo trên AWS Console: todo-app-frontend và todo-app-backend
# (hoặc dùng CLI - thay <AWS_ACCOUNT_ID> = Account ID của bạn):
aws ecr create-repository --repository-name todo-app-frontend --region ap-southeast-1
aws ecr create-repository --repository-name todo-app-backend --region ap-southeast-1

#==== Step 3: Tạo CodePipeline =====
# Source stage : CodeCommit repo todo-app-monorepo, branch main, Output artifact = "Full clone"
# Build stage  : CodeBuild, dùng buildspec.yml (biến môi trường AWS_ACCOUNT_ID, AWS_DEFAULT_REGION),
#                bật Privileged (để build Docker image), Artifacts = "No Artifact" (manifest đã nằm trong artifact Source)
# Deploy stage : Provider = "Amazon EKS", cluster = devops-test-cluster,
#                Deploy configuration = kubectl, Manifest file paths = aws-eks.yaml,
#                Subnet = chọn các PRIVATE subnet (KHÔNG chọn public subnet),
#                Security Group = các SG của EKS cluster.

#==== Step 4: Thêm IAM policy cho CodeBuild Service Role =====
#  - AmazonEC2ContainerRegistryFullAccess
#  - AWSCodeCommitFullAccess

#==== Step 5: Thêm IAM policy cho CodePipeline Service Role =====
#  - AmazonEC2ContainerRegistryFullAccess
#  - AWSCodeCommitFullAccess
#  - AWSCodeBuildDeveloperAccess
#  - CloudWatchLogsFullAccess
#  - AmazonEC2FullAccess
#  - Custom policy cho phép eks:DescribeCluster (xem nội dung dưới đây):
#    {
#      "Version": "2012-10-17",
#      "Statement": [
#        { "Effect": "Allow", "Action": [ "eks:DescribeCluster" ], "Resource": "*" }
#      ]
#    }

#==== Step 6: Gán Access Entry cho CodePipeline Service Role (quyền trên EKS) =====
# Thay <AWS_ACCOUNT_ID> và <CodePipeline-Service-Role-ARN> bằng giá trị thực tế.
aws eks create-access-entry \
  --cluster-name devops-test-cluster \
  --principal-arn arn:aws:iam::<AWS_ACCOUNT_ID>:role/service-role/<CodePipeline-Service-Role-ARN> \
  --type STANDARD

aws eks associate-access-policy \
  --cluster-name devops-test-cluster \
  --principal-arn arn:aws:iam::<AWS_ACCOUNT_ID>:role/service-role/<CodePipeline-Service-Role-ARN> \
  --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy \
  --access-scope type=cluster

# Verify:
aws eks list-associated-access-policies \
  --cluster-name devops-test-cluster \
  --principal-arn arn:aws:iam::<AWS_ACCOUNT_ID>:role/service-role/<CodePipeline-Service-Role-ARN>

#==== Step 7: Modify code để trigger CICD =====
git add .
git commit -m "Update TODO app backend and frontend v2"
git push origin master

#==== Step 8: Validate kết quả =====
kubectl get deployments
kubectl get pods
kubectl get svc
kubectl get ingress
# Truy cập ứng dụng qua DNS của ALB (đợi ALB provision xong, xem ở kubectl get ingress)
