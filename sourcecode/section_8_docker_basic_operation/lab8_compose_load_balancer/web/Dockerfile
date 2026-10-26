FROM node:20-alpine

WORKDIR /app

# Copy package.json trước để tận dụng layer cache khi chỉ sửa code
COPY package*.json ./
RUN npm install --omit=dev

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
