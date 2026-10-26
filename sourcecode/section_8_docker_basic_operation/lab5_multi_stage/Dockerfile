# ===== Stage 1: build source Node.js thành static file =====
FROM node:20 AS buildstep
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# ===== Stage 2: image cuối cùng chỉ chứa httpd + static file =====
FROM httpd:2.4

# Chỉ copy kết quả build (/app/build) từ stage 1, bỏ lại node_modules & source code
COPY --from=buildstep /app/build/ /usr/local/apache2/htdocs/

EXPOSE 80

CMD ["httpd-foreground"]
