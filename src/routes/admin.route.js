const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const adminController = require('../controllers/admin.controller');
const db = require('../config/database');
// Middleware kiểm tra admin đơn giản
// Routes
router.get('/', adminController.getDashboard);
router.get('/categories', adminController.getCategories);
router.post('/categories/add', adminController.addCategory);
router.get('/categories/:id', adminController.getCategoryById);
router.put('/categories/:id', adminController.updateCategory);
router.delete('/categories/:id', adminController.deleteCategory);

//tag
router.get('/tags', adminController.getTags);
router.post('/tags', adminController.addTag);
router.get('/tags/:id', adminController.getTagById);
router.put('/tags/:id', adminController.updateTag);
router.delete('/tags/:id', adminController.deleteTag);
//article
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'public/uploads/')
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
        cb(null, uniqueSuffix + '-' + file.originalname)
    }
});
const upload = multer({ 
    storage: storage,
    fileFilter: function (req, file, cb) {
        if (file.mimetype.startsWith('image/')) {
            cb(null, true);
        } else {
            cb(new Error('Not an image! Please upload an image.'), false);
        }
    }
});
// Articles routes
router.get('/articles', adminController.getArticles);
router.post('/articles', upload.single('featured_image'), async (req, res) => {
    try {
        const {
            title,
            abstract,
            content,
            category_id,
        } = req.body;

        // Xử lý featured image nếu có
        const featured_image = req.file ? `/uploads/${req.file.filename}` : null;

        // Sử dụng execute thay vì insert
        const [result] = await db.execute(
            `INSERT INTO articles (
                title,
                abstract,
                content,
                category_id,
                featured_image,
                status,
                author_id,
                publish_date,
                created_at,
                updated_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [
                title,
                abstract,
                content,
                category_id,
                featured_image,
                'published',
                req.session.authUser.id,
                new Date(),
                new Date(),
                new Date()
            ]
        );

        res.json({ 
            success: true,
            message: 'Article created successfully',
            articleId: result.insertId
        });
    } catch (error) {
        console.error('Error creating article:', error);
        res.status(500).json({ 
            success: false, 
            message: 'Error creating article' 
        });
    }
});
router.get('/articles/:id', adminController.getArticleById);
router.put('/articles/:id', upload.single('featuredImage'), adminController.updateArticle);
router.delete('/articles/:id', adminController.deleteArticle);

// user
router.get('/users', adminController.getUsers);
router.put('/users/:id/role', adminController.updateUserRole);
router.delete('/users/:id', adminController.deleteUser);
router.put('/drafts/:id/approve', adminController.approveDraft);
router.put('/drafts/:id/reject', adminController.rejectDraft);

//editor
router.get('/editor-categories', adminController.getEditorCategories);
router.post('/editor-categories/assign', adminController.assignEditorToCategory);
router.delete('/editor-categories/remove/:editorId/:categoryId', adminController.removeEditorFromCategory);
// Thêm route mới cho việc approve premium request
router.post('/premium-requests/:requestId/approve', adminController.approvePremiumRequest);

module.exports = router;