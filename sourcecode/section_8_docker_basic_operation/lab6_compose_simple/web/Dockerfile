# Base image Node.js 20
FROM node:20-alpine

# Thư mục làm việc trong container
WORKDIR /app

# Copy package.json & package-lock.json trước để tận dụng layer cache
COPY package*.json ./

# Cài dependencies
RUN npm install

# Copy toàn bộ source code
COPY . .

# Port ứng dụng lắng nghe
EXPOSE 3000

# Lệnh chạy ứng dụng
CMD ["npm", "start"]
