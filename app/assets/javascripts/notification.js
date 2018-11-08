$(function() {
    var $switchNotification = $('.js-switch-notification');
    if ($switchNotification.length > 0) {
        var $notificationWidget = $('.js-notifications');
        $switchNotification.click(function() {
            $notificationWidget.toggle();
            var $unread = $('.js-notification-unread');
            if ($unread.data('unread')) {
                $.ajax({
                    type: 'PATCH',
                    url: $unread.data('url'),
                    dataType: 'script'
                })
            }
        });
    }
});