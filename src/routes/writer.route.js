const express = require('express');
const controller = require('../controllers/writer.controller');  // Import the controller functions

const router = express.Router();

//mddwsmddws
const isAuth = (req, res, next) => {
    // if (!req.session.isAuthenticated) {
    //   return res.redirect('/login');
    // }
    next();
  };
  

// Route to get categories for the writer form
router.get('/writer', async (req, res) => {
    try {
        // Use the controller function to get categories
        const categories = await controller.getCategories();

        // Render the form with categories
        res.render('vwWriter/writer', { 
            layout: 'writer-editor.hbs',
            authUser: req.session.authUser,
            categories 
        });
    } catch (err) {
        console.error('Error fetching categories:', err);
        res.status(500).send('Error fetching categories');
    }
});

// Route to handle saving the content from the Froala editor
router.post('/writer/save', async (req, res) => {
    const { title, abstract, editorContent, category_id, author_id, premium, status, featured_image } = req.body;

    // Ensure required fields are present
    if (!title || !editorContent) {
        return res.status(400).json({ success: false, message: 'Title and content are required' });
    }

    const articleData = {
        title: title || null,
        abstract: abstract || null,
        content: editorContent || null,
        category_id: category_id || null,
        author_id: author_id || 1,
        status: status || 'draft',
        featured_image: featured_image || null,
        premium: premium || false
    };
   
    try {
        // Use the controller function to save the article
        const result = await controller.saveArticle(articleData);
        res.json({ success: true, message: 'Article saved successfully', data: result });
    } catch (err) {
        console.error('Error saving article:', err);
        res.status(500).json({ success: false, message: 'Error saving article' });
    }
});

// Route to get articles for the view page
router.get('/writer/view', isAuth,async (req, res) => {
    try {
        // Use the controller function to get articles
        const articles = await controller.getArticles();

        // Check if articles exist
        if (articles.length === 0) {
            return res.render('vwWriter/view', { articles: [], message: "No articles available." });
        }

        // Render the view and pass the articles data to Handlebars
        res.render('vwWriter/view', {
            articles: articles,
            authUser: req.session.authUser,
            layout: 'writer-editor.hbs'
        });
    } catch (err) {
        console.error('Error retrieving articles:', err);
        res.status(500).json({ success: false, message: 'Error retrieving articles' });
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

module.exports = router;  // Export the router instance
