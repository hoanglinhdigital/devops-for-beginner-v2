// Import các module cần thiết
const express = require('express');
const path = require('path');
const os = require('os');
const mysql = require('mysql2/promise');
const { createClient } = require('redis');

const app = express();
const PORT = process.env.PORT || 3000;

// Kết nối MySQL: host là tên service "db" trong docker-compose.yaml
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    connectionLimit: 5
});

// Kết nối Redis: host là tên service "cache" trong docker-compose.yaml
const redis = createClient({ url: `redis://${process.env.REDIS_HOST}:6379` });
redis.on('error', (err) => console.error('Redis error:', err.message));
redis.connect().catch((err) => console.error('Redis connect failed:', err.message));

// Phục vụ file tĩnh trong thư mục "public"
app.use(express.static(path.join(__dirname, 'public')));

// Thông tin container xử lý request + bộ đếm lượt truy cập lưu trên Redis
app.get('/api/info', async (req, res) => {
    try {
        const visits = await redis.incr('visits');
        res.json({ hostname: os.hostname(), visits });
    } catch (err) {
        res.status(500).json({ hostname: os.hostname(), error: err.message });
    }
});

// Đọc danh sách nhân viên từ MySQL
app.get('/api/employees', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT id, name, age, department, salary FROM employee ORDER BY id');
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
