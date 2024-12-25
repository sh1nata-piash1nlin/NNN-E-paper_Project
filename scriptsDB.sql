-- Tạo database mysql_webnews_db
CREATE DATABASE mysql_webnews_db;

-- Sử dụng database vừa tạo
USE mysql_webnews_db;

-- Bảng Users
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    pen_name VARCHAR(255) NULL,
    role VARCHAR(50) NOT NULL,
    dob DATE NULL,
    subscription_expiry TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng Categories
CREATE TABLE Categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    parent_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES Categories(id)
);

-- Bảng Tags
CREATE TABLE Tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng Articles
CREATE TABLE Articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    abstract TEXT NOT NULL,
    content TEXT NOT NULL,
    featured_image VARCHAR(255) NULL,
    category_id INT NOT NULL,
    author_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    publish_date TIMESTAMP NULL,
    is_premium BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(id),
    FOREIGN KEY (author_id) REFERENCES Users(id)
);

-- Bảng Article_Tags (bảng nối giữa Articles và Tags)
CREATE TABLE Article_Tags (
    article_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (article_id, tag_id),
    FOREIGN KEY (article_id) REFERENCES Articles(id),
    FOREIGN KEY (tag_id) REFERENCES Tags(id)
);

-- Bảng Comments
CREATE TABLE Comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES Articles(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Bảng Subscriptions
CREATE TABLE Subscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    start_date TIMESTAMP NOT NULL,
    expiry_date TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id)
);
ALTER TABLE Articles
ADD COLUMN featured BOOLEAN DEFAULT FALSE;

CREATE TABLE Editor_Categories (
    editor_id INT,
    category_id INT,
    assigned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (editor_id, category_id),
    FOREIGN KEY (editor_id) REFERENCES Users(id),
    FOREIGN KEY (category_id) REFERENCES Categories(id)
);

CREATE TABLE editor_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    article_id INT NOT NULL,
    article_name VARCHAR(255) NOT NULL,
    status ENUM('Accepted', 'Rejected') NOT NULL,
    rejection_reason TEXT,
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES Articles(id)
);

CREATE TABLE draft (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,       
    articles_id INT(11) NOT NULL,              
    date DATETIME NOT NULL,                      
    reject_reason TEXT                          
);
ALTER TABLE draft
ADD CONSTRAINT fk_articles FOREIGN KEY (articles_id) REFERENCES articles(id);

CREATE TABLE premium (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    card_number VARCHAR(16) NOT NULL,
    cvv VARCHAR(3) NOT NULL,
    start_day TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT unique_user_id UNIQUE (user_id)
);


ALTER TABLE premium ADD COLUMN status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending';
