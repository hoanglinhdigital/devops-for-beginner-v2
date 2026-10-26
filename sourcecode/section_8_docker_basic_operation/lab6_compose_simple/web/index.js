// Import các module cần thiết
const express = require('express');
const path = require('path');
const os = require('os');

const app = express();
const PORT = process.env.PORT || 3000;

// Phục vụ file tĩnh trong thư mục "public"
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
    res.redirect('/index.html');
});

app.get('/learning', (req, res) => {
    res.redirect('/learning.html');
});

// Trả về thông tin container đang xử lý request
app.get('/api/info', (req, res) => {
    res.json({
        hostname: os.hostname(),
        nodeEnv: process.env.NODE_ENV,
        appVersion: process.env.APP_VERSION
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
