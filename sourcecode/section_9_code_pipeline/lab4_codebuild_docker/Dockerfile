# Dùng base image Node.js 20 từ Amazon ECR Public Gallery (mirror Docker Official Image)
# để tránh lỗi rate limit khi CodeBuild pull image ẩn danh từ Docker Hub
FROM public.ecr.aws/docker/library/node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY . .

EXPOSE 3000

CMD [ "npm", "start" ]
