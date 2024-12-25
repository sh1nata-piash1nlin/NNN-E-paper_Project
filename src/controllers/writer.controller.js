const pool = require('../config/database');

// Function to get categories for the writer form
async function getCategories() {
    let connection;
    try {
        connection = await pool.getConnection();
        const [categories] = await connection.execute('SELECT id, name FROM categories');
        return categories;
    } catch (err) {
        console.error('Error fetching categories:', err);
        throw err;
    } finally {
        if (connection) connection.release(); // Ensure connection is released
    }
}

// Function to save a new article to the database
async function saveArticle(articleData) {
    let connection;
    try {
        connection = await pool.getConnection();
        
        // Log để debug chi tiết hơn
        console.log('Article data received:', {
            title: articleData.title,
            content: articleData.content,
            category_id: articleData.category_id,
            author_id: articleData.author_id,
            abstract: articleData.abstract,
            is_premium: articleData.is_premium,
            status: articleData.status,
            youtube_embed: articleData.youtube_embed,
            featured_image: articleData.featured_image
        });

        // Kiểm tra từng trường một và log ra
        const missingFields = [];
        if (!articleData.title) missingFields.push('title');
        if (!articleData.content) missingFields.push('content');
        if (!articleData.category_id) missingFields.push('category_id');
        if (!articleData.author_id) missingFields.push('author_id');

        if (missingFields.length > 0) {
            console.log('Missing fields:', missingFields);
            throw new Error(`Missing required fields: ${missingFields.join(', ')}`);
        }

        // Chuẩn bị câu query
        const query = `
            INSERT INTO Articles 
            (title, abstract, content, category_id, author_id, 
             status, is_premium, youtube_embed, featured_image, 
             created_at, updated_at) 
            VALUES 
            (?, ?, ?, ?, ?, 
             'draft', ?, ?, ?, 
             CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
        `;
        
        // Chuẩn bị values và log ra
        const values = [
            articleData.title,
            articleData.abstract || '',
            articleData.content,
            articleData.category_id,
            articleData.author_id,
            articleData.is_premium ? 1 : 0,
            articleData.youtube_embed || null,
            articleData.featured_image || null
        ];

        console.log('Query values:', values);

        // Thực thi query
        const [result] = await connection.execute(query, values);
        
        console.log('Insert result:', result);
        
        if (!result.insertId) {
            throw new Error('Failed to insert article');
        }

        // Thêm vào bảng draft
        const draftQuery = `
            INSERT INTO drafts (articles_id, date)
            VALUES (?, CURRENT_TIMESTAMP)
        `;
        await connection.execute(draftQuery, [result.insertId]);

        // Trả về bài viết đã lưu
        return {
            id: result.insertId,
            ...articleData,
            status: 'draft',
            created_at: new Date(),
            updated_at: new Date()
        };
    } catch (err) {
        console.error('Database error in saveArticle:', err);
        throw new Error(`Database error: ${err.message}`);
    } finally {
        if (connection) {
            console.log('Releasing connection');
            connection.release();
        }
    }
}

// Function to get all articles for the view page
async function getArticles() {
    let connection;
    try {
        connection = await pool.getConnection();
        
        // Sửa lại query để lấy bài viết mới nhất trước
        const query = `
            SELECT 
                articles.*,
                categories.name as category_name,
                DATE_FORMAT(articles.created_at, '%d/%m/%Y %H:%i') as formatted_date
            FROM articles
            LEFT JOIN categories ON articles.category_id = categories.id
            ORDER BY articles.created_at DESC
        `;
        
        const [articles] = await connection.execute(query);
        
        // Format lại content để preview
        articles.forEach(article => {
            if (article.content) {
                // Giới hạn độ dài của content preview
                const maxLength = 200;
                let contentPreview = article.content.replace(/<[^>]*>/g, ''); // Loại bỏ HTML tags
                if (contentPreview.length > maxLength) {
                    contentPreview = contentPreview.substring(0, maxLength) + '...';
                }
                article.content_preview = contentPreview;
            }
        });

        return articles;
    } catch (err) {
        console.error('Error getting articles:', err);
        throw err;
    } finally {
        if (connection) connection.release();
    }
}

// Function to get article details by ID
async function getArticleById(id) {
    let connection;
    try {
        connection = await pool.getConnection();
        
        const query = `
            SELECT 
                articles.*,
                categories.name as category_name,
                DATE_FORMAT(articles.created_at, '%d/%m/%Y %H:%i') as formatted_date
            FROM articles
            LEFT JOIN categories ON articles.category_id = categories.id
            WHERE articles.id = ?
        `;
        
        const [articles] = await connection.execute(query, [id]);
        
        if (articles.length === 0) {
            return null;
        }

        return articles[0];
    } catch (err) {
        console.error('Error getting article by ID:', err);
        throw err;
    } finally {
        if (connection) connection.release();
    }
}

async function editArticle(article) {
    let connection;
    try {
        connection = await pool.getConnection();

        // SQL query to update article with all necessary fields, including featured_image and featured
        const updateQuery = `
    UPDATE Articles
    SET 
        title = ?, 
        abstract = ?, 
        content = ?, 
        category_id = ?, 
        is_premium = ?, 
        featured_image = ?
    WHERE id = ?
`;


        // Execute the update query with all the required fields
        const result = await connection.execute(updateQuery, [
            article.title, 
            article.abstract, 
            article.content, 
            article.category_id, 
            article.premium, 
            article.featured_image,  // this is the image path or URL
            article.id
        ]);

        // Check if the update was successful
        if (result.affectedRows === 0) {
            return { success: false, message: 'Article not found or update failed' };
        }

        return { success: true };
    } catch (err) {
        console.error('Error saving article:', err);
        throw err;
    } finally {
        if (connection) connection.release(); // Ensure connection is released
    }
}

async function getArticlesByAuthor(authorId) {
    let connection;
    try {
        connection = await pool.getConnection();
        
        // Log để debug
        console.log('Getting articles for author:', authorId);
        
        const query = `
            SELECT 
                a.*,
                c.name as category_name,
                DATE_FORMAT(a.created_at, '%d/%m/%Y %H:%i') as formatted_date,
                DATE_FORMAT(a.publish_date, '%d/%m/%Y %H:%i') as formatted_publish_date
            FROM articles a
            LEFT JOIN categories c ON a.category_id = c.id
            WHERE a.author_id = ?
            ORDER BY 
                CASE a.status
                    WHEN 'rejected' THEN 1
                    WHEN 'draft' THEN 2
                    WHEN 'published' THEN 3
                END,
                a.created_at DESC
        `;
        
        console.log('Executing query:', query);
        console.log('With author ID:', authorId);
        
        const [articles] = await connection.execute(query, [authorId]);
        
        console.log('Query results:', articles);
        
        return articles;
    } catch (err) {
        console.error('Error in getArticlesByAuthor:', err);
        throw err;
    } finally {
        if (connection) connection.release();
    }
}

async function updateArticle(id, updateData) {
    let connection;
    try {
        connection = await pool.getConnection();
        await connection.beginTransaction();
        
        // Log để debug
        console.log('Updating article:', id);
        console.log('Update data:', updateData);

        // Đảm bảo không có giá trị undefined
        const sanitizedData = {
            title: updateData.title || null,
            abstract: updateData.abstract || null,
            content: updateData.content || null,
            category_id: updateData.category_id || null,
            is_premium: updateData.is_premium ? 1 : 0,
            youtube_embed: updateData.youtube_embed || null,
            featured_image: updateData.featured_image || null
        };

        // Cập nhật status thành 'draft'
        sanitizedData.status = 'draft';

        // Chuẩn bị câu query cho Articles
        const updateFields = [];
        const values = [];

        if (sanitizedData.title !== null) {
            updateFields.push('title = ?');
            values.push(sanitizedData.title);
        }

        if (sanitizedData.abstract !== null) {
            updateFields.push('abstract = ?');
            values.push(sanitizedData.abstract);
        }

        if (sanitizedData.content !== null) {
            updateFields.push('content = ?');
            values.push(sanitizedData.content);
        }

        if (sanitizedData.category_id !== null) {
            updateFields.push('category_id = ?');
            values.push(sanitizedData.category_id);
        }

        updateFields.push('is_premium = ?');
        values.push(sanitizedData.is_premium);

        if (sanitizedData.youtube_embed !== null) {
            updateFields.push('youtube_embed = ?');
            values.push(sanitizedData.youtube_embed);
        }

        if (sanitizedData.featured_image !== null) {
            updateFields.push('featured_image = ?');
            values.push(sanitizedData.featured_image);
        }

        // Thêm status và updated_at
        updateFields.push('status = ?');
        values.push('draft');
        updateFields.push('updated_at = CURRENT_TIMESTAMP');

        // Thêm article ID vào cuối mảng values
        values.push(id);

        const updateArticleQuery = `
            UPDATE Articles 
            SET ${updateFields.join(', ')}
            WHERE id = ?
        `;

        // Thực hiện update Articles
        const [articleResult] = await connection.execute(updateArticleQuery, values);
        
        if (articleResult.affectedRows === 0) {
            throw new Error('Article not found');
        }

        // Xóa bản ghi cũ trong bảng drafts nếu có
        await connection.execute('DELETE FROM drafts WHERE articles_id = ?', [id]);

        // Thêm bản ghi mới vào bảng drafts
        const insertDraftQuery = `
            INSERT INTO drafts (articles_id, date)
            VALUES (?, CURRENT_TIMESTAMP)
        `;
        await connection.execute(insertDraftQuery, [id]);

        // Commit transaction
        await connection.commit();

        // Trả về bài viết đã cập nhật
        return {
            id: id,
            ...sanitizedData,
            updated_at: new Date()
        };
    } catch (err) {
        if (connection) {
            await connection.rollback();
        }
        console.error('Database error in updateArticle:', err);
        throw new Error(`Database error: ${err.message}`);
    } finally {
        if (connection) {
            connection.release();
        }
    }
}

module.exports = {
    getCategories,
    saveArticle,
    getArticles,
    getArticleById,
    editArticle,
    getArticlesByAuthor,
    updateArticle
};