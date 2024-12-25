# 📰 News Website Project

<div align="center">
  
  ![Node.js](https://img.shields.io/badge/Node.js-v16+-green.svg)
  ![Express](https://img.shields.io/badge/Express-v4.21-blue.svg)
  ![MySQL](https://img.shields.io/badge/MySQL-v8+-blue.svg)
</div>

## 📑 Mục lục
- [Giới thiệu](#giới-thiệu)
- [Tính năng](#tính-năng)
- [Công nghệ sử dụng](#công-nghệ-sử-dụng)
- [Cài đặt](#cài-đặt)
- [Cấu trúc dự án](#cấu-trúc-dự-án)
- [API Documentation](#api-documentation)
- [Đóng góp](#đóng-góp)
- [License](#license)

## 🎯 Giới thiệu
Website tin tức với đầy đủ tính năng cho phép người dùng đọc, tìm kiếm tin tức, đăng ký tài khoản premium và quản lý nội dung. Hệ thống bao gồm nhiều vai trò người dùng: Guest, Subscriber, Writer, Editor và Admin.

## ✨ Tính năng

### 👥 Người dùng
- Đăng nhập/Đăng ký (OAuth với Google, Facebook)
- Đọc tin tức
- Tìm kiếm bài viết
- Bình luận bài viết
- Đăng ký tài khoản Premium

### 📝 Writer
- Viết bài với rich text editor (Froala)
- Quản lý bài viết cá nhân
- Upload hình ảnh

### ✏️ Editor
- Duyệt bài viết
- Quản lý danh mục
- Quản lý tags

### 👑 Admin
- Quản lý người dùng
- Phân quyền
- Thống kê báo cáo

## 🛠 Công nghệ sử dụng
- **Backend:** Node.js, Express
- **Database:** MySQL
- **Template Engine:** Handlebars
- **Editor:** Froala Editor
- **Authentication:** Passport.js
- **Other:** Sequelize ORM, Express Session

## ⚙️ Cài đặt

### Yêu cầu hệ thống
- Node.js (v16+)
- MySQL (v8+)
- npm/yarn

### Các bước cài đặt

1. Clone repository:
   ```bash
   git clone https://github.com/your-username/Web-Project.git
   cd Web-Project
   ```

2. Cài đặt dependencies:
   ```bash
   npm install
   ```

3. Tạo file `.env` và cấu hình:

   ```env
   URL_CLIENT=http://localhost:5000
   PORT=5000
   GOOGLE_CLIENT_ID=your_google_client_id
   GOOGLE_CLIENT_SECRET=your_google_client_secret
   FACEBOOK_APP_ID=your_facebook_app_id
   FACEBOOK_APP_SECRET=your_facebook_app_secret
   EMAIL_USER=
   EMAIL_PASS=
   ```

4. Tạo database và chạy migrations:
   - Chạy file `scriptDB.sql` và file `adddataDB.sql` trong source code.
   - Vào các folder `Config`, `ultils`: sửa password trong file `config.js`, `connectDB.js`, `database.js`, `db.js`.
   - Chạy migrations:
     ```bash
     npm run migrate
     ```

5. Khởi chạy ứng dụng:
   ```bash
   node app.js
   ```

## 📁 Cấu trúc dự án

```
Web-Project/
├── src/
│   ├── config/        # Cấu hình database
│   ├── controllers/   # Xử lý logic
│   ├── models/        # Models Sequelize
│   ├── public/        # Static files
│   ├── routes/        # Định tuyến
│   └── views/         # Templates Handlebars
├── .env
├── app.js
└── package.json
```

## 📚 API Documentation

### 🔐 Authentication Routes

```javascript
// Google OAuth
GET /auth/google           # Bắt đầu xác thực với Google
GET /auth/google/callback  # Callback URL sau khi xác thực Google

// Facebook OAuth
GET /auth/facebook         # Bắt đầu xác thực với Facebook
GET /auth/facebook/callback # Callback URL sau khi xác thực Facebook

// Profile & Logout
GET /auth/profile          # Xem thông tin profile
POST /auth/profile         # Cập nhật thông tin profile
POST /auth/logout          # Đăng xuất
```

### 👨‍💼 Editor Routes

```javascript
// Dashboard & Articles Management
GET /editor                        # Trang chính của editor
GET /editor/editorPOV              # Xem góc nhìn editor
GET /editor/article?id=:id         # Xem chi tiết bài viết

// Article Actions
GET /editor/accepted?id=:id        # Chấp nhận bài viết
GET /editor/rejected?id=:id        # Form từ chối bài viết
POST /editor/rejected              # Xử lý từ chối bài viết

// Article Editing
GET /editor/edit-article?id=:id    # Form chỉnh sửa bài viết
POST /editor/edit-article          # Cập nhật bài viết

// Profile
GET /profile-editor                # Trang profile của editor
```

### ✍️ Writer Routes

```javascript
// Article Management
GET /writer             # Trang chính của writer
GET /writer/view        # Xem danh sách bài viết đã viết

// Article Creation
POST /writer/save       # Lưu bài viết mới
```

### 🎯 Admin Routes

```javascript
// Dashboard
GET /admin                     # Trang quản trị chính

// Categories Management
GET /admin/categories          # Danh sách categories
POST /admin/categories/add     # Thêm category mới
GET /admin/categories/:id      # Chi tiết category
PUT /admin/categories/:id      # Cập nhật category
DELETE /admin/categories/:id   # Xóa category

// Tags Management
GET /admin/tags                # Danh sách tags
POST /admin/tags               # Thêm tag mới
GET /admin/tags/:id            # Chi tiết tag
PUT /admin/tags/:id            # Cập nhật tag
DELETE /admin/tags/:id         # Xóa tag

// Articles Management
GET /admin/articles            # Danh sách bài viết
POST /admin/articles           # Thêm bài viết mới
GET /admin/articles/:id        # Chi tiết bài viết
PUT /admin/articles/:id        # Cập nhật bài viết
DELETE /admin/articles/:id     # Xóa bài viết

// Users Management
GET /admin/users               # Danh sách users
PUT /admin/users/:id/role      # Cập nhật role user
DELETE /admin/users/:id        # Xóa user

// Editor Categories
GET /admin/editor-categories           # Quản lý phân công editor
POST /admin/editor-categories/assign   # Phân công editor cho category
DELETE /admin/editor-categories/remove/:eid/:cid # Xóa phân công editor

// Premium Management
POST /admin/premium-requests/:requestId/approve # Duyệt yêu cầu premium
```

### 📱 Guest/Public Routes

```javascript
// Articles
GET /articles            # Danh sách bài viết
GET /articles/:id        # Chi tiết bài viết
GET /categories/:id      # Bài viết theo category

// Search & Filter
GET /search              # Tìm kiếm bài viết
GET /tags/:id            # Bài viết theo tag

// Comments
POST /articles/comments  # Thêm bình luận
```

### 💎 Subscriber Routes

```javascript
// Premium Content
GET /subscriber/articles     # Danh sách bài viết premium
GET /subscriber/article/:id  # Xem bài viết premium

// Profile
GET /subscriber/profile      # Trang profile subscriber
```

## 🤝 Đóng góp
Mọi đóng góp đều được chào đón!

## 📄 License

Nguyễn Đức Trí  
Trần Huy Hoàng  
Phạm Nam Hào  
Nguyễn Hải Dương  
Trần Đức Trung  

---
<div align="center">
  <sub>Built with ❤️ by Your Team</sub>
</div>
