const express = require('express');
const controller = require('../controllers/writer.controller');  // Import the controller functions
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const router = express.Router();

// Thêm middleware để parse JSON
router.use(express.json());

//mddwsmddws
const isAuth = (req, res, next) => {
    // if (!req.session.isAuthenticated) {
    //   return res.redirect('/login');
    // }
    next();
  };
  

// Cấu hình multer cho upload ảnh
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        // Sử dụng đường dẫn tuyệt đối
        const uploadPath = path.join(__dirname, '../public/uploads');
        cb(null, uploadPath);
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({ 
    storage: storage,
    fileFilter: function (req, file, cb) {
        // Kiểm tra loại file
        if (file.mimetype.startsWith('image/')) {
            cb(null, true);
        } else {
            cb(new Error('Not an image! Please upload an image.'), false);
        }
    }
});

// Thêm middleware để đảm bảo thư mục tồn tại
const ensureUploadDirExists = (req, res, next) => {
    const uploadDir = path.join(__dirname, '../public/uploads');
    if (!fs.existsSync(uploadDir)){
        fs.mkdirSync(uploadDir, { recursive: true });
    }
    next();
};

// Định nghĩa middleware checkWriterRole
const checkWriterRole = (req, res, next) => {
    if (!req.session.isAuthenticated) {
        return res.redirect('/login');
    }
    
    // Log để debug
    console.log('Session:', req.session);
    console.log('User role:', req.session.authUser?.role);

    if (req.session.authUser && (req.session.authUser.role === 'writer' || req.session.authUser.role === 'editor')) {
        next();
    } else {
        res.status(403).render('403', {
            layout: false,
            message: 'You need writer privileges to access this page'
        });
    }
};

// Route chính cho writer dashboard
router.get('/', checkWriterRole, async function (req, res) {
    try {
        const categories = await controller.getCategories();
        
        res.render('vwWriter/writer', {
            layout: 'writer-editor',
            categories: categories,
            authUser: req.session.authUser,
            isAuthenticated: req.session.isAuthenticated
        });
    } catch (err) {
        console.error('Error in writer dashboard:', err);
        res.status(500).send('Server Error');
    }
});

// Route to handle saving the content from the Froala editor
router.post('/writer/save', async (req, res) => {
    try {
        console.log('Received request body:', req.body);

        const { title, abstract, content, category_id, is_premium } = req.body;

        // Ensure required fields are present
        if (!title || !content) {
            return res.status(400).json({ 
                success: false, 
                message: 'Title and content are required' 
            });
        }

        const articleData = {
            title: title,
            abstract: abstract || '',
            content: content,
            category_id: category_id,
            author_id: req.session.authUser.id,
            status: 'draft',
            featured_image: null,
            is_premium: is_premium || false
        };

        console.log('Article data to save:', articleData);
   
        // Use the controller function to save the article
        const result = await controller.saveArticle(articleData);
        res.json({ 
            success: true, 
            message: 'Article saved successfully', 
            data: result 
        });
    } catch (err) {
        console.error('Error saving article:', err);
        res.status(500).json({ 
            success: false, 
            message: 'Error saving article' 
        });
    }
});

// Route để xem danh sách bài viết
router.get('/view', checkWriterRole, async function (req, res) {
    try {
        console.log('User session:', req.session.authUser);
        
        const authorId = req.session.authUser.id;
        console.log('Author ID:', authorId);
        
        const articles = await controller.getArticlesByAuthor(authorId);
        console.log('Retrieved articles:', articles);
        
        const groupedArticles = {
            published: articles.filter(a => a.status === 'published'),
            draft: articles.filter(a => a.status === 'draft'),
            rejected: articles.filter(a => a.status === 'rejected')
        };
        
        console.log('Grouped articles:', groupedArticles);

        res.render('vwWriter/view', {
            layout: 'writer-editor',
            groupedArticles,
            empty: articles.length === 0,
            authUser: req.session.authUser
        });
    } catch (err) {
        console.error('Error in /writer/view:', err);
        res.status(500).send('Error retrieving articles');
    }
});

// Route to get article details by ID
router.get('/writer/articles/:id', isAuth,async (req, res) => {
    const articleId = req.params.id; // Get the article ID from the route parameter

    try {
        // Use the controller function to get article details by ID
        const { article, comments } = await controller.getArticleById(articleId);

        if (!article) {
            return res.render('vwWriter/articleNotFound', {
                layout: 'writer-editor.hbs',
                authUser: req.session.authUser,
                message: "Article not found." });
        }

        // Render the article detail page with comments
        res.render('article-detail.hbs', {
            article,
            comments,
            authUser: req.session.authUser,
            layout: 'writer-editor.hbs'
        });
    } catch (err) {
        console.error('Error retrieving article:', err);
        res.status(500).json({ success: false, message: 'Error retrieving article' });
    }
});

// Route to get article details by ID for editing
router.get('/writer/edit/:id', isAuth,async (req, res) => {
    const articleId = req.params.id; // Get the article ID from the route parameter

    try {
        // Use the controller function to get article details by ID
        const { article } = await controller.getArticleById(articleId);

        // Render the article edit page, passing the article details to the frontend
        res.render('vwWriter/edit', {
            article,   
            authUser: req.session.authUser,        // Article data to pre-fill the editor
            layout: 'writer-editor.hbs'
        });
    } catch (err) {
        console.error('Error retrieving article for editing:', err);
        res.status(500).json({ success: false, message: 'Error retrieving article' });
    }
});
router.post('/writer/edit', async (req, res) => {
    
    const { id ,title, abstract, editorContent, category_id, premium, status, featured_image } = req.body;
    console.log('Request Body:', req.body); // Log to see if the body is correct
    // Ensure required fields are present
    if (!title || !editorContent) {
        return res.status(400).json({ success: false, message: 'Title and content are required' });
    }

    const articleData = {
        id : id,
        title: title || null,
        abstract: abstract || null,
        content: editorContent || null,
        category_id: category_id ,
        status: status || 'draft',
        featured_image: featured_image || null,
        premium: premium || false
    };
    
 
    try {
        console.log('Prepared article data:', articleData);

        // Use the controller function to save the article
        const result = await controller.editArticle(articleData);
        res.json({ success: true, message: 'Article edited successfully', data: result });
    } catch (err) {
        console.error('Error editing article:', err);
        res.status(500).json({ success: false, message: 'Error editing article' });
    }
});

// Route để upload ảnh từ Froala Editor
router.post('/upload-image', ensureUploadDirExists, upload.single('file'), (req, res) => {
    if (req.file) {
        res.json({
            link: `/uploads/${req.file.filename}`
        });
    } else {
        res.status(400).json({ error: 'No file uploaded' });
    }
});

// Route để lưu bài viết với ảnh đại diện
router.post('/save', checkWriterRole, async function (req, res) {
    try {
        console.log('Full request body:', req.body);
        console.log('Files:', req.files);

        // Kiểm tra dữ liệu đầu vào
        if (!req.body.title || !req.body.content || !req.body.category_id) {
            return res.status(400).json({
                success: false,
                message: 'Missing required fields'
            });
        }

        // Chuẩn bị dữ liệu cho bài viết
        const articleData = {
            title: req.body.title.trim(),
            abstract: req.body.abstract ? req.body.abstract.trim() : '',
            content: req.body.content,  // Sử dụng content thay vì editorContent
            category_id: req.body.category_id,
            author_id: req.session.authUser.id,
            is_premium: req.body.is_premium === 'true',
            status: 'draft',
            youtube_embed: req.body.youtube_url || null,
            featured_image: null
        };

        // Xử lý featured image nếu có
        if (req.files && req.files.featured_image) {
            const image = req.files.featured_image;
            const imageName = `${Date.now()}-${image.name}`;
            const imagePath = `./public/uploads/${imageName}`;
            
            await image.mv(imagePath);
            articleData.featured_image = `/uploads/${imageName}`;
        }

        console.log('Prepared article data:', articleData);

        // Lưu bài viết
        const savedArticle = await controller.saveArticle(articleData);
        
        console.log('Article saved successfully:', savedArticle);

        res.json({
            success: true,
            message: 'Article saved successfully',
            article: savedArticle
        });

    } catch (err) {
        console.error('Error in save route:', err);
        res.status(500).json({
            success: false,
            message: err.message || 'Error saving article'
        });
    }
});

// Route để edit bài viết
router.get('/edit/:id', async (req, res) => {
    try {
        const articleId = req.params.id;
        
        // Lấy thông tin bài viết
        const article = await controller.getArticleById(articleId);
        
        // Lấy danh sách categories để hiển thị trong form
        const categories = await controller.getCategories();
        
        // Log để debug
        console.log('Article data:', article);
        
        if (!article) {
            return res.status(404).send('Article not found');
        }

        res.render('vwWriter/edit', {
            layout: 'writer-editor',
            article: article,
            categories: categories,
            authUser: req.session.authUser
        });
    } catch (err) {
        console.error('Error getting article for edit:', err);
        res.status(500).send('Error retrieving article');
    }
});

// Route để xem chi tiết bài viết
router.get('/articles/:id', async (req, res) => {
    try {
        const articleId = req.params.id;
        const article = await controller.getArticleById(articleId);
        
        if (!article) {
            return res.status(404).send('Article not found');
        }

        // Log để debug
        console.log('Article detail:', article);

        res.render('vwWriter/article', {
            layout: 'writer-editor',
            article: article,
            authUser: req.session.authUser
        });
    } catch (err) {
        console.error('Error getting article details:', err);
        res.status(500).send('Error retrieving article details');
    }
});

// Route để lưu bài viết mới

router.post('/edit/:id', checkWriterRole, async function (req, res) {
    try {
        const articleId = req.params.id;
        console.log('Editing article:', articleId);
        console.log('Request body:', req.body);

        // Kiểm tra dữ liệu đầu vào
        if (!req.body.title || !req.body.content) {
            return res.json({
                success: false,
                message: 'Title and content are required'
            });
        }

        // Chuẩn bị dữ liệu cập nhật
        const updateData = {
            title: req.body.title.trim(),
            abstract: req.body.abstract ? req.body.abstract.trim() : '',
            content: req.body.content,
            category_id: req.body.category_id,
            is_premium: req.body.is_premium,
            youtube_embed: req.body.youtube_url || null
        };

        console.log('Update data:', updateData);

        // Cập nhật bài viết
        const result = await controller.updateArticle(articleId, updateData);
        
        res.json({
            success: true,
            message: 'Article updated successfully',
            article: result
        });

    } catch (err) {
        console.error('Error in edit route:', err);
        res.json({
            success: false,
            message: err.message || 'Error updating article'
        });
    }
});

module.exports = router;  // Export the router instance