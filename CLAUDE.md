# CLAUDE.md — DevOps on AWS for Beginner Course Repository

## Giới thiệu repository

Repository chứa toàn bộ tài liệu giảng dạy của khoá học **"DevOps on AWS for Beginner – Tiếng Việt"**.
Outline khoá học: `outline.md` — dùng để tham chiếu sự liên quan giữa các chương, đảm bảo nội dung có tính liên kết và độ khó tăng dần. Khi thêm/sửa/xoá chapter trong `index.html` (sidebar), cập nhật `outline.md` tương ứng (và ngược lại).

### Cấu trúc thư mục

```
index.html                  # Shell chính: header + sidebar + iframe
styles.css                  # Global stylesheet
script.js                   # Global script (copy button cho code block...)
mermaid-config.js           # Global style cho Mermaid chart/diagram
prism.css / prism.js        # Syntax highlight
welcome.html                # Trang chào mừng mặc định
outline.md                  # Outline khoá học
sections/
  section_1/
    chapter_1.html          # Nội dung từng chương
    chapter_2.html
    ...
  section_N/ ...
assets/
  svg-icon/                 # Icon dùng cho diagram và minh hoạ
  images/                   # Ảnh minh hoạ cho chapter
  aws-svg/                  # Biểu tượng cho các dịch vụ AWS.
images/                     # Thư mục ảnh riêng cho từng Section
  section<number>/          # Thư mục ảnh riêng cho từng Chapter
mermaid/                    # File mermaid mẫu / nguồn diagram
sourcecode/                 # Source code cho các bài lab
  section_N/
    lab_<tên>/
      main.tf / commands.sh / ...
slide_old                   # Phiên bản cũ sử dụng Powerpoint của khóa học này.
source_code_old             # Source code phiên bản cũ của khóa học này. Một số thư mục không có là chapter không có chuẩn bị source code.
```

### Cách navigation hoạt động

- Sidebar bên trái được định nghĩa tĩnh trong `index.html`.
- Click chapter → iframe load `sections/section_<N>/chapter_<M>.html`.
- Chapter file tham chiếu stylesheet qua đường dẫn tương đối `../../styles.css`.
- Preview bằng Live Server: mở `index.html` ở thư mục gốc project.

---

## Đối tượng học viên

- Junior Developer, Fullstack Developer, sinh viên IT năm cuối hoặc mới tốt nghiệp, Muốn tìm hiểu về Cloud Computing & AWS.
- Không yêu cầu kiến thức đầu vào vì tất cả đều được hướng dẫn từng bước.

## Mục tiêu sau khi hoàn thành khóa học

- Nắm vững các khái niệm về Cloud Computing & AWS
- Có kiến thức cơ bản về các dịch vụ AWS (Networking, Compute, Storage, Database, Container...)
- Tự tin tạo, cấu hình cũng như thao tác với các dịch vụ AWS thường dùng.
- Có khả năng tự thiết kế hệ thống trên AWS theo tiêu chuẩn Best Practice.
- Tự tin triển khai hệ thống & ứng dụng lên AWS theo kiến trúc đã thiết kế.
- Trang bị kiến thức cần thiết để chuẩn bị thi chứng chỉ SAA & DVA.
- Final Assignment: Bài tập lớn giúp bạn làm quen với thiết kế & triển khai hệ thống trong dự án thực tế.

**Môi trường thực hành:** AWS và các dịch vụ cơ bản như EC2, ECR, Lambda, RDS, DynamoDB, SNS, SQS, EventBridge, ElasticBeanstalk, API Gateway, Route53, CloudFront, LoadBalancer, S3, Backup, Security Services...
**Công cụ:** Git, VS Code, MySQL Workbench, AWS CLI, DrawIO.

---

## Quy tắc tạo nội dung chương học

### Yêu cầu kỹ thuật bắt buộc

- File chapter là **HTML/CSS/JS thuần (Vanilla JS)** — ưu tiên sử dụng taildwind css nếu hỗ trợ.
- Ưu tiên sử dụng global style `styles.css`, `mermaid-config.js`, `script.js` để đảm bảo nhất quán, dễ thay đổi phong cách sau này.
- Không thêm sidebar hay header vào chapter file — layout do `index.html` quản lý qua iframe.

---

### A. Nội dung bài lý thuyết (khái niệm, pattern, dịch vụ)

Cấu trúc theo thứ tự:

1. **Giới thiệu** — 2–4 câu: khái niệm/pattern/dịch vụ này là gì, giải quyết vấn đề gì.
2. **Các đặc điểm / tính năng chính** — danh sách gạch đầu dòng 5-6 mục (`<ul class="feature-list">`).
3. **Mô hình kiến trúc** — dùng Mermaid flowchart/architecture diagram mô tả cách các component kết nối và giao tiếp. KHÔNG dùng HTML để vẽ diagram. Dùng icon trong `assets/svg-icon` và `assets/aws-svg`; nếu không có icon phù hợp, dùng Emoji. Tham khảo `mermaid/sample-flowchart.mermaid`.
4. **Trade-off** — ưu/nhược điểm, khi nào nên / không nên dùng (bắt buộc với bài về pattern kiến trúc).
5. **Use Cases** — 2–3 tình huống thực tế.
6. **Thông tin bổ sung** — giới hạn kỹ thuật, lưu ý, cách tiết kiệm chi phí.

Chapter mẫu cho phần lý thuyết: `sections\sample\theory_sample.html`
---

### B. Nội dung bài Lab thực hành

Cấu trúc theo thứ tự:

1. **Mục tiêu** — những gì học viên sẽ thực hiện và đạt được.
2. **Kiến trúc tổng quan** — Mermaid diagram (như mục A.3). *Với các bài lab quá đơn giản như: Tạo EC2 instance, Tạo RDS Database, Tạo S3 bucket... chỉ cần vẽ Icon service kèm kết nối từ PC Local tới dịch vụ của AWS là đủ.
3. **Yêu cầu trước khi bắt đầu** — tool cần cài (Terraform, AWS CLI, Java, Node.js...), tài khoản dịch vụ, kết quả cần có từ lab trước.
4. **Các bước thực hành** — chi tiết từng bước, ưu tiên dùng command. Command phải copy-paste được, không rút gọn.
5. **Kiểm tra kết quả** — cách xác nhận hệ thống hoạt động đúng.
6. **Troubleshoot** — các lỗi thường gặp và cách xử lý.
7. **Dọn dẹp resource** — hướng dẫn xoá toàn bộ resource đã tạo (áp dụng cho lab có tạo resource trên Cloud). Luôn nhắc nhở về chi phí (NAT Gateway, ALB, RDS, ElastiCache...).

**Format:** Command nhúng trực tiếp vào HTML. Dùng `<pre class="command-line">` (hoặc `<pre class="code-block">`) cho command, `<div class="mermaid">` cho diagram.
**Source code lab** (Terraform, script, app) lưu tại `sourcecode/section_<N>/lab_<tên>/`, ví dụ `sourcecode/section_5/lab_vpc_3tier/main.tf`.
**Cách trình bày** Hướng dẫn học viên cách sử dụng AWS Console để thao tác, hạn chế sử dụng AWS CLI vì đây là khóa học cơ bản. Các step trong bài lab mang tính nhận biết, không bắt học viên phải nhớ giao diện AWS Console vì nó có thể thay đổi theo thời gian.
Cách mô tả đúng: Tạo EC2 instance với các thông số
  - Instance size: t3.small
  - subnet: Default
  - Security Group: Default
  - EBS Volume: 10GB
Cách mô tả sai: Click vào nút Create Instance,... Chọn Next,... Bấm OK ở góc phải trên.

Chapter mẫu cho phần Lab thực hành: `sections\sample\lab_sample.html`
---

## Phong cách thiết kế (Design System)

**Phong cách:** Tươi sáng, light. Nền trắng là chủ đạo. Không dùng nền tối trừ header của trang shell và code block.

```css
font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
```

| Vai trò | Màu | Hex |
|---|---|---|
| Background chính | Trắng | #ffffff |
| Background trang | Xám nhạt | #f8fafc |
| Accent chính | Tím | #8f0c9e |
| Accent phụ | Xanh dương | #2d0ae0 |
| Text chính | Xanh đen | #1e293b |
| Text muted | Xám | #64748b |
| Border | Xám nhạt | #e2e8f0 |
| Success | Xanh lá | #16a34a |
| Warning | Vàng | #d97706 |

CSS component chuẩn nằm trong `styles.css` — dùng lại trong chapter file và `index.html`, chỉ bổ sung khi thật sự cần.

---

## Template mẫu — Bài lý thuyết

```html
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>TÊN CHƯƠNG – DevOps on AWS for Beginner</title>
  <link rel="stylesheet" href="../../styles.css" />
  <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
  <script src="../../mermaid-config.js"></script>
  <link rel="stylesheet" href="../../prism.css" />
  <script src="../../prism.js"></script>
  <script src="../../script.js"></script>
</head>
<body class="chapter-body">

  <div class="chapter-breadcrumb">
    <span class="section-part">N. Tên Section</span>
    <span class="sep">/</span>
    <span class="chapter-part">Tên Chapter</span>
  </div>

  <h2 class="section-heading">Giới thiệu</h2>
  <p>...</p>

  <h2 class="section-heading">Đặc điểm chính</h2>
  <ul class="feature-list">
    <li>...</li>
  </ul>

  <h2 class="section-heading">Mô hình kiến trúc</h2>
  <div class="mermaid">
  flowchart LR
      Client["👤 Client"] --> API["API"]
  </div>

  <h2 class="section-heading">Trade-off</h2>
  <p>...</p>

  <h2 class="section-heading">Use Cases</h2>
  <div class="usecase-grid">
    <div class="usecase-card">
      <h4>Tên use case</h4>
      <p>Mô tả...</p>
    </div>
  </div>

  <h2 class="section-heading">Thông tin bổ sung</h2>
  <p>...</p>

</body>
</html>
```

## Template mẫu — Bài Lab

```html
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Lab: Tạo EC2 instance đầu tiên của bạn – DevOps on AWS for Beginner</title>
  <link rel="stylesheet" href="../../styles.css" />
  <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
  <script src="../../mermaid-config.js"></script>
  <link rel="stylesheet" href="../../prism.css" />
  <script src="../../prism.js"></script>
  <script src="../../script.js"></script>
</head>
<body class="chapter-body">

  <div class="chapter-breadcrumb">
    <span class="section-part">N. Tên Section</span>
    <span class="sep">/</span>
    <span class="chapter-part">Lab: Tên Lab</span>
  </div>

  <h2 class="section-heading">Mục tiêu</h2>
  <ul class="feature-list">
    <li>...</li>
  </ul>

  <h2 class="section-heading">Kiến trúc tổng quan</h2>
  <div class="mermaid">
  flowchart LR
      A["..."] --> B["..."]
  </div>

  <h2 class="section-heading">Yêu cầu trước khi bắt đầu</h2>
  <ul class="feature-list">
    <li>Terraform &gt;= 1.6, AWS CLI v2 đã cấu hình profile</li>
  </ul>

  <h2 class="section-heading">Các bước thực hành</h2>
  <ol class="step-list">
    <li>
      <div>
        <strong>Bước 1: Tên bước</strong>
        <p>Mô tả...</p>
        <pre class="command-line" data-prompt="$" data-output="2, 5"><code class="language-bash">terraform init</code></pre>
      </div>
    </li>
  </ol>

  <!-- ⚠️ step-list: `.step-list > li` là flex container. Mỗi <li> chỉ có DUY NHẤT MỘT <div> con trực tiếp;
       mọi nội dung (<pre>, <p>, <h4>, alert...) phải nằm BÊN TRONG div đó, nếu không sẽ bị xếp ngang. -->

  <h2 class="section-heading">Troubleshoot</h2>
  <div class="alert alert-warning">
    <strong>Lỗi:</strong> ... <br/>
    <strong>Nguyên nhân:</strong> ... <br/>
    <strong>Giải pháp:</strong> ...
  </div>

  <h2 class="section-heading">Dọn dẹp resource</h2>
  <div class="alert alert-info">Luôn xoá resource sau khi thực hành để tránh phát sinh chi phí.</div>
  <pre class="command-line" data-prompt="$"><code class="language-bash">terraform destroy -auto-approve</code></pre>

</body>
</html>
```

---

## Quy ước đặt tên file

| Loại | Đường dẫn | Ví dụ |
|---|---|---|
| Chapter nội dung | `sections/section_N/chapter_M.html` | `sections/section_7/chapter_4.html` |
| Source code lab | `sourcecode/section_N/lab_<tên>/` | `sourcecode/section_5/lab_vpc_3tier/` |
| Terraform entry point | `sourcecode/section_N/lab_<tên>/main.tf` | snake_case |
| Shell script | `sourcecode/section_N/lab_<tên>/commands.sh` | snake_case |
| Ảnh minh hoạ | `assets/images/<tên-kebab-case>.png` | `assets/images/three-tier-architecture.png` |

---

## Không làm

- Không thêm sidebar/header vào chapter file — đây là nội dung iframe.
- Không rút gọn command trong bài lab — học viên cần copy-paste được ngay.
- Không sử dụng command dạng `cat <nội dung> EOF`, code đã copy được, chỉ cần hướng dẫn học viên tạo file code sau đó copy.
- Không dùng inline-css; tái sử dụng class trong `styles.css`, chỉ thêm khi cần thiết.
- Không đặt `<pre>`, `<p>`, `<h4>` hay bất kỳ element nào là con trực tiếp của `<li>` trong `.step-list` ngoài một `<div>` duy nhất.
- Không hard-code credential/secret trong source code lab; dùng biến môi trường hoặc `terraform.tfvars` (đã gitignore).
