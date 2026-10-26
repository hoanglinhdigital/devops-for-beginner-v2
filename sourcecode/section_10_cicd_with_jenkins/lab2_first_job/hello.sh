# Lab 2 – Nội dung build step "Execute shell" của job Freestyle lab02-hello-job
# Copy toàn bộ nội dung dưới đây vào ô Command của build step.
echo "Build Step 01 - Hello world"
echo "DevOps on AWS for Beginner"
echo "Job đang chạy với user: $(whoami)"
echo "Thư mục làm việc (workspace): $(pwd)"
date
echo "Hello Jenkins - build ${BUILD_NUMBER}" > hello.txt
ls -la
