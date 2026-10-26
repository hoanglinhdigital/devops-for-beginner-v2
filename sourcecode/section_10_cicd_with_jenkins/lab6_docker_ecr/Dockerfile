# Dùng base image Node.js 22 từ Amazon ECR Public Gallery (mirror Docker Official Image)
# để tránh lỗi rate limit khi Jenkins pull image ẩn danh từ Docker Hub
FROM public.ecr.aws/docker/library/node:22-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY . .

EXPOSE 3000

CMD [ "npm", "start" ]
