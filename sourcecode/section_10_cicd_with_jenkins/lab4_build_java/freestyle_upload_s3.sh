# Lab 4 (Phần 2) – Build step "Execute shell" của job Freestyle lab04-java-freestyle
# Thay <your-suffix> bằng hậu tố bucket bạn đã tạo.
ls -la "${WORKSPACE}/target/"
aws s3 cp "${WORKSPACE}/target/my-app-1.0-SNAPSHOT.jar" "s3://jenkins-artifact-<your-suffix>/lab04-java-freestyle/${BUILD_NUMBER}/"
