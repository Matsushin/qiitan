$(function() {
    var $form = $('.js-article-body');
    if ($form.length > 0) {
        $form.keyup(checkChange($form));
        url = $('#js-article-preview').data('previewUrl');
        updatePreview($form.val(), url);

        function checkChange($form) {
            var oldBody = newBody = $form.val();
            return function () {
                newBody = $form.val();
                if (oldBody != newBody) {
                    oldBody = newBody;
                    updatePreview(oldBody, url);
                }
            }
        }
    }

    function updatePreview(body, url) {
        $.ajax({
            type: 'POST',
            url: url,
            dataType: 'script',
            data: {body: body}
        })
    }
});