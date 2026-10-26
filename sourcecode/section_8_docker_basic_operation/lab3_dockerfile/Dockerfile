# Base image: Apache HTTP Server
FROM httpd:2.4

# Biến môi trường (có thể đọc trong container bằng lệnh env)
ENV APP_VERSION=1.0

# Copy code HTML từ workspace vào thư mục web root của httpd
COPY ./web/ /usr/local/apache2/htdocs/

# Ghi version vào file để kiểm tra (chạy lúc build image)
RUN echo "version=${APP_VERSION}" > /usr/local/apache2/htdocs/version.txt

# Khai báo port ứng dụng lắng nghe
EXPOSE 80

# Lệnh chạy khi container start (chạy httpd ở foreground)
CMD ["httpd-foreground"]
