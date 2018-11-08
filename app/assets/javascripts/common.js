$(function() {
    toastr.options = {
        "progressBar": true,
        "closeButton": true,
        "positionClass": "toast-bottom-left",
    }

    var $switchNotification = $('.js-switch-notification');
    if ($switchNotification.length > 0) {
        var $notificationWidget = $('.js-notifications');
        $switchNotification.click(function() {
            $notificationWidget.toggle();
        });
    }
});