$(document).ready(function() {
    // Initialize Froala Editor
    if ($('#froala-editor').length) {
        new FroalaEditor('#froala-editor', {
            heightMin: 300,
            placeholderText: 'Start writing your content...',
            // Thêm các options cho image và video
            imageUploadURL: '/writer/upload-image',
            imageUploadParams: {
                type: 'content'
            },
            videoInsertButtons: ['videoBack', '|', 'videoByURL', 'videoEmbed'],
            events: {
                'image.uploaded': function (response) {
                    console.log('Image uploaded:', response);
                },
                'image.error': function (error, response) {
                    console.error('Image upload error:', error, response);
                }
            }
        });
    }

    // Handle form submission
    $('#save-button').click(function() {
        const formData = new FormData($('form')[0]);
        
        // Xử lý YouTube URL (nếu có)
        const youtubeEmbed = $('#youtubeEmbed').val();
        if (youtubeEmbed && youtubeEmbed.trim() !== '') {
            formData.append('youtube_embed', youtubeEmbed);
        }
        
        $.ajax({
            url: '/writer/save',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if (response.success) {
                    alert('Article saved successfully!');
                    window.location.href = '/writer/view';
                } else {
                    alert('Error saving article: ' + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error('Upload error:', xhr.responseText);
                alert('Error saving article: ' + error);
            }
        });
    });
});