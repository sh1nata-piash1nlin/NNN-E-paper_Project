INSERT INTO Users (username, password, email, full_name, pen_name, role, dob, subscription_expiry) VALUES
('admin', 'hashedpassword', 'admin@example.com', 'Quản Trị Viên', NULL, 'admin', '1990-01-01', NULL),
('editor1', 'hashedpassword', 'editor1@example.com', 'Biên Tập Viên Minh', 'BTV Minh', 'editor', '1985-05-15', NULL),
('writer1', 'hashedpassword', 'writer1@example.com', 'Phóng Viên Hùng', 'PV Hùng', 'writer', '1988-12-20', NULL),
('editor2', 'hashedpassword', 'editor2@example.com', 'Biên Tập Viên Hoang', 'BTV Hoang', 'editor', '1981-04-14', NULL),
('writer2', 'hashedpassword', 'writer2@example.com', 'Phóng Viên Hùng', 'PV Duong', 'writer', '1990-1-2', NULL),
('subscriber1', 'hashedpassword', 'subscriber1@example.com', 'Độc Giả Nguyễn', NULL, 'subscriber', '1992-07-10', DATE_ADD(NOW(), INTERVAL 7 DAY));
INSERT INTO Users (id, username, password, email, full_name, role)
VALUES
(6, 'user6', 'password6', 'user6@example.com', 'User Six', 'author'),
(7, 'user7', 'password7', 'user7@example.com', 'User Seven', 'author'),
(15, 'user15', 'password15', 'user15@example.com', 'User Fifteen', 'author'),
(16, 'user16', 'password16', 'user16@example.com', 'User Sixteen', 'author');
INSERT INTO Users (id, username, password, email, full_name, role)
VALUES (8, 'user8', 'password8', 'user8@example.com', 'User Eight', 'reader');

INSERT INTO Tags (id, name, created_at, updated_at) VALUES
(1, 'Thời sự', NOW(), NOW()),
(2, 'Kinh tế', NOW(), NOW()),
(3, 'Công nghệ', NOW(), NOW()),
(4, 'Du lịch', NOW(), NOW()),
(5, 'Sức khỏe', NOW(), NOW()),
(6, 'Giáo dục', NOW(), NOW()),
(7, 'Môi trường', NOW(), NOW()),
(8, 'Khoa học', NOW(), NOW());
-- Parent Categories
INSERT INTO Categories (id, name, parent_id, created_at, updated_at) VALUES 
(1, 'Thời sự', NULL, NOW(), NOW()),
(6, 'Kinh doanh', NULL, NOW(), NOW()),
(8, 'Sức khỏe', NULL, NOW(), NOW()),
(9, 'Đời sống', NULL, NOW(), NOW()),
(10, 'Du lịch', NULL, NOW(), NOW()),
(11, 'Số hóa', NULL, NOW(), NOW()),
(12, 'Xe', NULL, NOW(), NOW());
-- Child Categories of "Thời sự"
INSERT INTO Categories (id, name, parent_id, created_at, updated_at) VALUES 
(13, 'Chính trị', 1, NOW(), NOW()),
(14, 'Dân sinh', 1, NOW(), NOW()),
(15, 'Lao động - Việc làm', 1, NOW(), NOW()),
(16, 'Giao thông', 1, NOW(), NOW());

-- Child Categories of "Kinh doanh"
INSERT INTO Categories (id, name, parent_id, created_at, updated_at) VALUES 
(17, 'NetZero', 6, NOW(), NOW()),
(18, 'Quốc tế', 6, NOW(), NOW()),
(19, 'Doanh nghiệp', 6, NOW(), NOW()),
(20, 'Chứng khoán', 6, NOW(), NOW());

-- Child Categories of "Sức khỏe"
INSERT INTO Categories (id, name, parent_id, created_at, updated_at) VALUES 
(21, 'Tin tức', 8, NOW(), NOW()),
(22, 'Các bệnh', 8, NOW(), NOW()),
(23, 'Sống khỏe', 8, NOW(), NOW()),
(24, 'Vaccine', 8, NOW(), NOW());

-- Child Categories of "Đời sống"
INSERT INTO Categories (id, name, parent_id, created_at, updated_at) VALUES 
(25, 'Nhịp sống', 9, NOW(), NOW()),
(26, 'Tổ ấm', 9, NOW(), NOW()),
(27, 'Bài học sống', 9, NOW(), NOW()),
(28, 'Cooking', 9, NOW(), NOW());

-- Child Categories of "Du lịch"
INSERT INTO Categories (id, name, parent_id, created_at, updated_at) VALUES 
(29, 'Điểm đến', 10, NOW(), NOW()),
(30, 'Ẩm thực', 10, NOW(), NOW()),
(31, 'Dấu chân', 10, NOW(), NOW()),
(32, 'Tư vấn', 10, NOW(), NOW());

-- Child Categories of "Số hóa"
INSERT INTO Categories (id, name, parent_id, created_at, updated_at) VALUES 
(33, 'Công nghệ', 11, NOW(), NOW()),
(34, 'Sản phẩm', 11, NOW(), NOW()),
(35, 'Blockchain', 11, NOW(), NOW()),
(36, 'Kinh nghiệm', 11, NOW(), NOW());

-- Child Categories of "Xe"
INSERT INTO Categories (id, name, parent_id, created_at, updated_at) VALUES 
(37, 'Thị trường', 12, NOW(), NOW()),
(38, 'Car Awards 2024', 12, NOW(), NOW()),
(39, 'Diễn đàn', 12, NOW(), NOW()),
(40, 'V-Car', 12, NOW(), NOW());


-- Articles under "Thời sự - Dân sinh"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(5, 'Giá cả thị trường biến động', 'Phân tích nguyên nhân và ảnh hưởng', 'Thị trường đang trải qua...', 'img5.jpg', 14, 2, 'published', NOW(), false, NOW(), NOW()),
(6, 'Cải cách giáo dục mới', 'Đánh giá chính sách cải cách', 'Bộ giáo dục vừa ban hành...', 'img6.jpg', 14, 3, 'published', NOW(), false, NOW(), NOW());

-- Articles under "Thời sự - Lao động - Việc làm"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(7, 'Cơ hội việc làm sau dịch', 'Những xu hướng việc làm mới', 'Sau đại dịch, thị trường lao động...', 'img7.jpg', 15, 1, 'published', NOW(), true, NOW(), NOW()),
(8, 'Thị trường lao động ngày càng khắt khe', 'Phân tích yêu cầu tuyển dụng', 'Do yêu cầu ngày càng cao...', 'img8.jpg', 15, 2, 'published', NOW(), false, NOW(), NOW());

-- Articles under "Thời sự - Giao thông"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(9, 'Dự án metro sắp hoàn thành', 'Tiến độ xây dựng tuyến metro mới', 'Dự án metro được mong đợi...', 'img9.jpg', 16, 3, 'published', NOW(), false, NOW(), NOW()),
(10, 'Tai nạn giao thông giảm mạnh', 'Nguyên nhân và giải pháp', 'Nhờ các biện pháp an toàn...', 'img10.jpg', 16, 1, 'published', NOW(), false, NOW(), NOW());

-- Articles under "Kinh doanh - NetZero"
INSERT INTO articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(17, 'NetZero và tương lai năng lượng sạch', 'Tìm hiểu về NetZero', 'Các giải pháp NetZero...', 'img3.jpg', 17, 15, 'published', NOW(), true, NOW(), NOW()),
(18, 'Chứng khoán tăng điểm', 'Phân tích thị trường chứng khoán', 'Thị trường chứng khoán đã tăng...', 'img4.jpg', 17, 15, 'published', NOW(), false, NOW(), NOW()),

(11, 'Kinh tế toàn cầu phục hồi', 'Phân tích các chỉ số kinh tế quốc tế', 'Nền kinh tế thế giới đang...', 'img11.jpg', 18, 16, 'published', NOW(), true, NOW(), NOW()),
(12, 'Chiến tranh thương mại Mỹ-Trung', 'Ảnh hưởng đến doanh nghiệp Việt Nam', 'Cuộc chiến thương mại tiếp tục...', 'img12.jpg', 18, 16, 'published', NOW(), false, NOW(), NOW()),


(13, 'Doanh nghiệp vượt khó trong dịch', 'Câu chuyện thành công của doanh nghiệp nhỏ', 'Trong bối cảnh khó khăn...', 'img13.jpg', 19, 6, 'published', NOW(), false, NOW(), NOW()),
(14, 'Khởi nghiệp công nghệ năm 2024', 'Xu hướng và thách thức', 'Các startup công nghệ đang...', 'img14.jpg', 19, 6, 'published', NOW(), true, NOW(), NOW()),


(15, 'Dự báo thị trường chứng khoán 2025', 'Nhận định của chuyên gia', 'Năm 2025, thị trường dự báo...', 'img15.jpg', 20, 7, 'published', NOW(), false, NOW(), NOW()),
(16, 'Cổ phiếu công nghệ bùng nổ', 'Lý do và tiềm năng đầu tư', 'Cổ phiếu công nghệ đang có...', 'img16.jpg', 20, 7, 'published', NOW(), false, NOW(), NOW());
-- Articles for "Sức khỏe - Tin tức"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(19, 'Cập nhật thông tin y tế mới nhất', 'Những tin tức nóng hổi về y tế...', 'Chi tiết về các thông báo y tế mới...', 'health1.jpg', 21, 7, 'published', NOW(), false, NOW(), NOW()),
(20, 'Báo cáo về dịch bệnh mùa đông', 'Tình hình dịch bệnh trong mùa đông này...', 'Phân tích chi tiết về các bệnh trong mùa đông...', 'health2.jpg', 21, 7, 'published', NOW(), false, NOW(), NOW());

-- Articles for "Sức khỏe - Các bệnh"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(21, 'Phòng chống bệnh mùa lạnh', 'Hướng dẫn phòng tránh các bệnh thường gặp...', 'Chi tiết về cách bảo vệ sức khỏe...', 'health3.jpg', 22, 7, 'published', NOW(), false, NOW(), NOW()),
(22, 'Các dấu hiệu nhận biết bệnh tim mạch', 'Những triệu chứng quan trọng cần biết...', 'Các dấu hiệu và cách phòng tránh bệnh...', 'health4.jpg', 22, 7, 'published', NOW(), false, NOW(), NOW());

-- Articles for "Sức khỏe - Sống khỏe"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(23, 'Thói quen ăn uống lành mạnh', 'Ăn uống sao cho khoa học...', 'Phân tích các lợi ích của chế độ ăn uống...', 'health5.jpg', 23, 6, 'published', NOW(), false, NOW(), NOW()),
(24, 'Tập thể dục hàng ngày giúp ích gì?', 'Lợi ích của việc tập thể dục mỗi ngày...', 'Chi tiết về các lợi ích cho sức khỏe...', 'health6.jpg', 23, 6, 'published', NOW(), false, NOW(), NOW());

-- Articles for "Sức khỏe - Vaccine"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(25, 'Lịch tiêm chủng vaccine mới nhất', 'Hướng dẫn tiêm chủng cho trẻ em...', 'Chi tiết về các loại vaccine cần thiết...', 'vaccine1.jpg', 24, 6, 'published', NOW(), true, NOW(), NOW()),
(26, 'Hiệu quả của vaccine trong việc chống dịch', 'Phân tích mức độ hiệu quả của vaccine...', 'Chi tiết về các nghiên cứu gần đây...', 'vaccine2.jpg', 24, 6, 'published', NOW(), false, NOW(), NOW());
-- Articles for "Đời sống - Nhịp sống"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(27, 'Cuộc sống thành thị và nhịp sống nhanh', 'Thành phố lớn và cách sống hiện đại...', 'Phân tích về sự thay đổi...', 'life1.jpg', 25, 15, 'published', NOW(), false, NOW(), NOW()),
(28, 'Cuộc sống ở vùng quê thanh bình', 'Cảm nhận về một cuộc sống đơn giản...', 'Những điều tuyệt vời tại vùng quê...', 'life2.jpg', 25, 15, 'published', NOW(), false, NOW(), NOW());

-- Articles for "Đời sống - Tổ ấm"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(29, 'Cách xây dựng một tổ ấm hạnh phúc', 'Những bí quyết giữ gìn hạnh phúc...', 'Chi tiết về các phương pháp...', 'home1.jpg', 26, 16, 'published', NOW(), false, NOW(), NOW()),
(30, 'Lựa chọn nội thất phù hợp cho gia đình', 'Những mẹo hay trong trang trí...', 'Hướng dẫn chọn nội thất...', 'home2.jpg', 26, 16, 'published', NOW(), false, NOW(), NOW());
-- Articles for "Du lịch - Điểm đến"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(31, '10 địa điểm du lịch hấp dẫn 2024', 'Danh sách những nơi nên đến trong năm tới...', 'Chi tiết về từng địa điểm du lịch...', 'travel1.jpg', 29, 15, 'published', NOW(), false, NOW(), NOW()),
(32, 'Khám phá vẻ đẹp bí ẩn của vùng Tây Bắc', 'Những nét đẹp độc đáo của Tây Bắc...', 'Bài viết chi tiết về văn hóa và phong cảnh...', 'travel2.jpg', 29, 15, 'published', NOW(), false, NOW(), NOW());

-- Articles for "Du lịch - Ẩm thực"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(33, 'Các món ăn đường phố nổi tiếng thế giới', 'Ẩm thực đường phố không thể bỏ lỡ...', 'Chi tiết về các món ăn đường phố hấp dẫn...', 'food1.jpg', 32, 16, 'published', NOW(), false, NOW(), NOW()),
(34, 'Ẩm thực châu Âu và nét tinh tế', 'Những đặc trưng của ẩm thực châu Âu...', 'Phân tích sự khác biệt và nổi bật của các món ăn...', 'food2.jpg', 30, 7, 'published', NOW(), true, NOW(), NOW());

-- Articles for "Du lịch - Dấu chân"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(35, 'Hành trình khám phá Himalaya', 'Câu chuyện về chuyến đi đến dãy Himalaya...', 'Những trải nghiệm đáng nhớ khi leo núi...', 'journey1.jpg', 31, 15, 'published', NOW(), false, NOW(), NOW()),
(36, 'Ghi lại dấu chân ở sa mạc Sahara', 'Hành trình phiêu lưu trên sa mạc rộng lớn...', 'Kinh nghiệm du lịch và khám phá Sahara...', 'journey2.jpg', 31, 16, 'published', NOW(), false, NOW(), NOW());

-- Articles for "Du lịch - Tư vấn"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(37, 'Làm thế nào để đi du lịch tiết kiệm?', 'Những mẹo nhỏ giúp tiết kiệm chi phí...', 'Hướng dẫn chi tiết và các lời khuyên...', 'advice1.jpg', 32, 7, 'published', NOW(), false, NOW(), NOW()),
(38, 'Hướng dẫn xin visa du lịch các nước', 'Những thủ tục cần chuẩn bị khi xin visa...', 'Bài viết hướng dẫn từng bước để xin visa...', 'advice2.jpg', 32, 6, 'published', NOW(), true, NOW(), NOW());

-- Articles for "Số hóa - Blockchain"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(43, 'Blockchain và ứng dụng trong tài chính', 'Cách blockchain đang thay đổi tài chính...', 'Phân tích sự ảnh hưởng của blockchain...', 'blockchain1.jpg', 35, 7, 'published', NOW(), false, NOW(), NOW()),
(44, 'Top các dự án blockchain mới nổi', 'Những dự án nổi bật trong ngành...', 'Bài viết chi tiết về các dự án mới...', 'blockchain2.jpg', 35, 16, 'published', NOW(), true, NOW(), NOW());

-- Articles for "Số hóa - Kinh nghiệm"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(45, 'Cách bảo vệ dữ liệu cá nhân hiệu quả', 'Các bước đơn giản để bảo vệ dữ liệu...', 'Hướng dẫn chi tiết về bảo mật dữ liệu...', 'experience1.jpg', 36, 7, 'published', NOW(), false, NOW(), NOW()),
(46, 'Làm sao để làm việc hiệu quả từ xa?', 'Các công cụ và mẹo làm việc từ xa...', 'Chi tiết các kỹ thuật và phần mềm...', 'experience2.jpg', 36, 16, 'published', NOW(), false, NOW(), NOW());
-- Articles for "Số hóa - Công nghệ"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(39, 'Những xu hướng công nghệ nổi bật 2024', 'Dự đoán về các xu hướng mới...', 'Phân tích về những xu hướng sẽ thay đổi...', 'tech1.jpg', 33, 7, 'published', NOW(), false, NOW(), NOW()),
(40, '5 phát minh đột phá trong năm nay', 'Những phát minh sẽ thay đổi thế giới...', 'Chi tiết về từng phát minh và tầm quan trọng...', 'tech2.jpg', 33, 6, 'published', NOW(), false, NOW(), NOW());

-- Articles for "Số hóa - Sản phẩm"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(41, 'Review iPhone 15 Pro Max', 'Đánh giá chi tiết mẫu iPhone mới nhất...', 'Phân tích điểm mạnh và yếu của sản phẩm...', 'product1.jpg', 34, 6, 'published', NOW(), true, NOW(), NOW()),
(42, 'Laptop tốt nhất cho dân lập trình', 'Những mẫu laptop tốt nhất...', 'So sánh và đánh giá các dòng laptop...', 'product2.jpg', 34, 7, 'published', NOW(), false, NOW(), NOW());
-- Articles for "Xe - Thị trường"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(47, 'Thị trường xe hơi Việt Nam 2024', 'Phân tích xu hướng thị trường...', 'Chi tiết về tình hình kinh doanh xe hơi...', 'car1.jpg', 37, 15, 'published', NOW(), false, NOW(), NOW()),
(48, 'Doanh số xe điện tăng mạnh', 'Tăng trưởng nhanh chóng của xe điện...', 'Bài viết về các yếu tố thúc đẩy...', 'car2.jpg', 37, 15, 'published', NOW(), true, NOW(), NOW());

-- Articles for "Xe - Car Awards 2024"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(49, 'Car Awards 2024: Những cái tên nổi bật', 'Những mẫu xe nào sẽ chiến thắng?', 'Chi tiết về các giải thưởng năm nay...', 'carawards1.jpg', 38, 16, 'published', NOW(), false, NOW(), NOW()),
(50, 'Đánh giá xe tham dự Car Awards', 'Điểm mạnh và yếu của các xe tham gia...', 'Phân tích từng mẫu xe chi tiết...', 'carawards2.jpg', 38, 16, 'published', NOW(), false, NOW(), NOW());

-- Articles for "Xe - Diễn đàn"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(51, 'Chia sẻ kinh nghiệm mua xe cũ', 'Những điều cần lưu ý khi mua xe cũ...', 'Các lời khuyên từ chuyên gia...', 'forum1.jpg', 39, 6, 'published', NOW(), false, NOW(), NOW()),
(52, 'Diễn đàn xe hơi: Xu hướng mới', 'Cộng đồng yêu xe bàn về xu hướng...', 'Tổng hợp ý kiến từ các thành viên...', 'forum2.jpg', 39, 6, 'published', NOW(), false, NOW(), NOW());

-- Articles for "Xe - V-Car"
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(53, 'V-Car: Xe điện hàng đầu Việt Nam', 'Lợi thế của V-Car trong thị trường...', 'Chi tiết về các công nghệ sử dụng...', 'vcar1.jpg', 40, 7, 'published', NOW(), false, NOW(), NOW()),
(54, 'Khám phá thiết kế thông minh của V-Car', 'Những điểm nổi bật trong thiết kế...', 'Phân tích các chi tiết đặc biệt...', 'vcar2.jpg', 40, 7, 'published', NOW(), true, NOW(), NOW());

-- Bài viết cho danh mục Sức khỏe (ID: 8)
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(55, 'Chế độ ăn uống lành mạnh mùa dịch', 'Những thực phẩm tăng cường sức đề kháng...', 'Chi tiết về các loại thực phẩm và chế độ ăn...', 'health_diet.jpg', 8, 7, 'published', NOW(), false, NOW(), NOW()),
(56, 'Tập thể dục tại nhà hiệu quả', 'Hướng dẫn các bài tập đơn giản...', 'Các bài tập chi tiết và hướng dẫn thực hiện...', 'home_exercise.jpg', 8, 7, 'published', NOW(), false, NOW(), NOW()),
(57, 'Bí quyết ngủ ngon mỗi ngày', 'Các phương pháp cải thiện giấc ngủ...', 'Nghiên cứu về giấc ngủ và các tips hữu ích...', 'sleep_tips.jpg', 8, 7, 'published', NOW(), true, NOW(), NOW());

-- Bài viết cho danh mục Đời sống (ID: 9)
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(58, 'Bí quyết trang trí nhà cửa', 'Những ý tưởng độc đáo cho không gian sống...', 'Hướng dẫn chi tiết về cách trang trí...', 'home_decor.jpg', 9, 15, 'published', NOW(), false, NOW(), NOW()),
(59, 'Kỹ năng sống cần thiết', 'Những kỹ năng quan trọng trong cuộc sống...', 'Phân tích và hướng dẫn rèn luyện kỹ năng...', 'life_skills.jpg', 9, 15, 'published', NOW(), false, NOW(), NOW()),
(60, 'Nuôi dạy con cái thời hiện đại', 'Phương pháp giáo dục trẻ hiệu quả...', 'Các nghiên cứu và kinh nghiệm thực tế...', 'parenting.jpg', 9, 16, 'published', NOW(), true, NOW(), NOW());

-- Bài viết cho danh mục Công nghệ (ID: 11)
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(61, 'AI và tương lai công nghệ', 'Xu hướng phát triển AI trong năm 2024...', 'Phân tích chi tiết về các xu hướng AI...', 'ai_future.jpg', 11, 6, 'published', NOW(), false, NOW(), NOW()),
(62, 'Bảo mật thông tin cá nhân', 'Cách bảo vệ dữ liệu trong thời đại số...', 'Hướng dẫn các biện pháp bảo mật...', 'cybersecurity.jpg', 11, 6, 'published', NOW(), false, NOW(), NOW()),
(63, '5G và cách mạng công nghiệp', 'Tác động của 5G đến đời sống...', 'Nghiên cứu về ảnh hưởng của 5G...', '5g_impact.jpg', 11, 7, 'published', NOW(), true, NOW(), NOW());

-- Bài viết cho danh mục Xe (ID: 12)
INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(64, 'Xu hướng xe điện 2024', 'Thị trường xe điện và những mẫu xe mới...', 'Đánh giá chi tiết các mẫu xe điện...', 'electric_cars.jpg', 12, 15, 'published', NOW(), false, NOW(), NOW()),
(65, 'Bảo dưỡng xe mùa mưa', 'Những điều cần lưu ý khi bảo dưỡng xe...', 'Hướng dẫn chi tiết cách bảo dưỡng...', 'car_maintenance.jpg', 12, 16, 'published', NOW(), false, NOW(), NOW()),
(66, 'So sánh các dòng xe SUV', 'Đánh giá chi tiết các mẫu SUV hot...', 'Phân tích ưu nhược điểm của từng mẫu...', 'suv_comparison.jpg', 12, 7, 'published', NOW(), true, NOW(), NOW());

INSERT INTO Comments (id, article_id, user_id, comment_text, comment_date) VALUES
(1, 5, 8, 'Bài viết phân tích rất chi tiết và sâu sắc về giá cả thị trường', NOW()),
(2, 22, 8, 'Thông tin về cơ hội việc làm rất hữu ích và cập nhật', NOW());

-- Comments cho bài viết Sức khỏe
INSERT INTO Comments (article_id, user_id, comment_text, comment_date) VALUES
(55, 8, 'Bài viết rất hữu ích cho mùa dịch, cảm ơn tác giả!', NOW()),
(55, 6, 'Tôi đã áp dụng và thấy sức khỏe cải thiện rõ rệt', NOW()),
(56, 7, 'Các bài tập rất phù hợp để tập tại nhà, dễ thực hiện', NOW()),
(57, 8, 'Đã thử áp dụng và ngủ ngon hơn hẳn', NOW());

-- Comments cho bài viết Đời sống
INSERT INTO Comments (article_id, user_id, comment_text, comment_date) VALUES
(58, 6, 'Những ý tưởng trang trí rất sáng tạo và tiết kiệm', NOW()),
(59, 7, 'Bài viết giúp tôi nhận ra nhiều điều cần cải thiện', NOW()),
(60, 8, 'Phương pháp dạy con rất hay, phù hợp với trẻ hiện đại', NOW()),
(60, 6, 'Đã áp dụng và thấy con có nhiều thay đổi tích cực', NOW());

-- Comments cho bài viết Công nghệ
INSERT INTO Comments (article_id, user_id, comment_text, comment_date) VALUES
(61, 7, 'Phân tích rất sâu sắc về xu hướng AI', NOW()),
(62, 8, 'Những tip bảo mật rất hữu ích trong thời đại số', NOW()),
(63, 6, 'Bài viết giúp hiểu rõ hơn về tác động của 5G', NOW()),
(63, 7, 'Rất thích cách phân tích về ảnh hưởng của 5G đến đời sống', NOW());

-- Comments cho bài viết Xe
INSERT INTO Comments (article_id, user_id, comment_text, comment_date) VALUES
(64, 8, 'Thông tin về xe điện rất hữu ích cho người định mua xe', NOW()),
(65, 6, 'Những lưu ý bảo dưỡng xe rất chi tiết và dễ hiểu', NOW()),
(66, 7, 'So sánh các dòng SUV giúp ích nhiều cho việc chọn xe', NOW()),
(66, 8, 'Phân tích ưu nhược điểm rất khách quan và chuyên sâu', NOW());

INSERT INTO Articles (id, title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) VALUES
(70, 'ChatGPT và cuộc cách mạng AI trong năm 2024', 'Những tiến bộ và ứng dụng mới nhất của ChatGPT trong đời sống và công việc...', 'Chi tiết về các tính năng mới và cách ChatGPT đang thay đổi cách chúng ta làm việc...', 'chatgpt_2024.jpg', 11, 6, 'published', NOW(), false, NOW(), NOW()),

(71, 'Xu hướng Metaverse và thực tế ảo', 'Khám phá thế giới ảo và tương lai của công nghệ Metaverse...', 'Phân tích chi tiết về sự phát triển của Metaverse và ảnh hưởng đến tương lai...', 'metaverse.jpg', 11, 7, 'published', NOW(), true, NOW(), NOW()),

(72, 'Blockchain và tiền số trong năm 2024', 'Những thay đổi quan trọng trong thị trường tiền số và công nghệ blockchain...', 'Đánh giá thị trường crypto và các ứng dụng mới của blockchain...', 'blockchain_2024.jpg', 11, 6, 'published', NOW(), false, NOW(), NOW()),

(73, 'Công nghệ 6G - Tương lai của kết nối', 'Tìm hiểu về công nghệ 6G và những tiềm năng trong tương lai...', 'Chi tiết về công nghệ 6G và cách nó sẽ thay đổi cách chúng ta kết nối...', '6g_future.jpg', 11, 7, 'published', NOW(), true, NOW(), NOW()),

(74, 'Trí tuệ nhân tạo trong y tế', 'AI đang cách mạng hóa ngành y tế như thế nào...', 'Phân tích các ứng dụng của AI trong chẩn đoán và điều trị bệnh...', 'ai_healthcare.jpg', 11, 6, 'published', NOW(), false, NOW(), NOW()),

(75, 'Bảo mật thông tin trong kỷ nguyên số', 'Những thách thức và giải pháp bảo mật mới nhất...', 'Hướng dẫn chi tiết về cách bảo vệ thông tin cá nhân trong thời đại số...', 'cybersecurity_2024.jpg', 11, 7, 'published', NOW(), false, NOW(), NOW()),

(76, 'Xe tự lái và AI trong giao thông', 'Sự phát triển của công nghệ xe tự lái và ứng dụng AI trong giao thông...', 'Chi tiết về các công nghệ mới trong xe tự lái và hệ thống giao thông thông minh...', 'self_driving.jpg', 11, 6, 'published', NOW(), true, NOW(), NOW()),

(77, 'Công nghệ xanh và phát triển bền vững', 'Các giải pháp công nghệ cho vấn đề môi trường...', 'Phân tích các công nghệ mới giúp bảo vệ môi trường và phát triển bền vững...', 'green_tech.jpg', 11, 7, 'published', NOW(), false, NOW(), NOW()),

(78, 'Internet vệ tinh và tương lai của kết nối', 'Starlink và cuộc cách mạng internet vệ tinh...', 'Chi tiết về công nghệ internet vệ tinh và tác động đến kết nối toàn cầu...', 'satellite_internet.jpg', 11, 6, 'published', NOW(), true, NOW(), NOW()),

(79, 'Quantum Computing - Cuộc cách mạng tính toán', 'Tìm hiểu về máy tính lượng tử và ứng dụng...', 'Phân tích chi tiết về công nghệ quantum computing và tiềm năng trong tương lai...', 'quantum_computing.jpg', 11, 7, 'published', NOW(), false, NOW(), NOW());

-- Thêm một số comments cho các bài viết mới
INSERT INTO Comments (article_id, user_id, comment_text, comment_date) VALUES
(70, 6, 'Bài viết rất hay về ChatGPT, cần có thêm nhiều ví dụ thực tế', NOW()),
(70, 7, 'Thông tin cập nhật và hữu ích', NOW()),
(71, 8, 'Metaverse là tương lai của công nghệ', NOW()),
(72, 6, 'Phân tích rất sâu sắc về blockchain', NOW()),
(73, 7, 'Rất mong đợi công nghệ 6G', NOW()),
(74, 8, 'AI trong y tế thực sự là một bước tiến quan trọng', NOW()),
(75, 6, 'Bảo mật là vấn đề quan trọng cần được quan tâm', NOW()),
(76, 7, 'Xe tự lái sẽ là tương lai của giao thông', NOW()),
(77, 8, 'Công nghệ xanh rất cần thiết cho môi trường', NOW()),
(78, 6, 'Internet vệ tinh sẽ thay đổi cách chúng ta kết nối', NOW()),
(79, 7, 'Quantum Computing thực sự là một bước đột phá', NOW());

-- đếm view
ALTER TABLE Articles ADD COLUMN view_count INT DEFAULT 5;


--Full text search cho tính năng search
ALTER TABLE Articles ADD FULLTEXT(title, abstract, content);


-- them data cho công nghệ article category
INSERT INTO Articles (title, abstract, content, featured_image, category_id, author_id, status, publish_date, is_premium, created_at, updated_at) 
VALUES 
('Trí tuệ nhân tạo GPT-4 và tương lai', 'Khám phá những tiến bộ mới nhất của GPT-4...', 'Chi tiết về các ứng dụng và tiềm năng của GPT-4 trong tương lai...', 'gpt4.jpg', 33, 7, 'published', NOW(), false, NOW(), NOW()),

('Công nghệ Metaverse phát triển mạnh', 'Xu hướng và ứng dụng của Metaverse...', 'Phân tích chi tiết về sự phát triển của công nghệ Metaverse...', 'metaverse.jpg', 33, 6, 'published', NOW(), true, NOW(), NOW()),

('Bảo mật và An ninh mạng 2024', 'Những thách thức mới trong an ninh mạng...', 'Các giải pháp và xu hướng bảo mật mới nhất...', 'security.jpg', 33, 7, 'published', NOW(), false, NOW(), NOW()),

('Công nghệ 6G - Tương lai của kết nối', 'Nghiên cứu và phát triển công nghệ 6G...', 'Tìm hiểu về tiềm năng và ứng dụng của công nghệ 6G...', '6g.jpg', 33, 6, 'published', NOW(), true, NOW(), NOW()),

('Quantum Computing tiến bộ vượt bậc', 'Những đột phá trong máy tính lượng tử...', 'Chi tiết về các nghiên cứu và ứng dụng mới...', 'quantum.jpg', 33, 7, 'published', NOW(), false, NOW(), NOW()),

('IoT và Smart Home 2024', 'Xu hướng nhà thông minh và IoT...', 'Các thiết bị và giải pháp nhà thông minh mới nhất...', 'smarthome.jpg', 33, 6, 'published', NOW(), false, NOW(), NOW()),

('Edge Computing và 5G', 'Sự kết hợp giữa Edge Computing và 5G...', 'Phân tích về tiềm năng và ứng dụng trong thực tế...', 'edge5g.jpg', 33, 7, 'published', NOW(), true, NOW(), NOW()),

('Công nghệ AR/VR mới nhất', 'Phát triển của thực tế ảo và tăng cường...', 'Các ứng dụng mới của AR/VR trong công nghiệp và giải trí...', 'arvr.jpg', 33, 6, 'published', NOW(), false, NOW(), NOW()),

('Robotics và Tự động hóa', 'Xu hướng robot và tự động hóa 2024...', 'Những tiến bộ mới trong lĩnh vực robotics...', 'robotics.jpg', 33, 7, 'published', NOW(), true, NOW(), NOW()),

('Cloud Computing và Multi-cloud', 'Xu hướng điện toán đám mây...', 'Phân tích về các giải pháp đám mây hiện đại...', 'cloud.jpg', 33, 6, 'published', NOW(), false, NOW(), NOW()),

('Công nghệ Blockchain và Web3', 'Phát triển của Web3 và Blockchain...', 'Những ứng dụng mới của công nghệ blockchain...', 'web3.jpg', 33, 7, 'published', NOW(), true, NOW(), NOW());



INSERT INTO Users (
    username, 
    password, 
    email, 
    full_name, 
    role, 
    subscription_expiry
) VALUES (
    'premium', 
    '$2b$10$8DGMmKxaK8SrVkwxgTtJvuLwWGYxZPPWWrKaZtqDmZ3w7tXVFyaVe', -- password là "123456"
    'premium@example.com',
    'Premium User',
    'subscriber',
    DATE_ADD(NOW(), INTERVAL 7 DAY)
);