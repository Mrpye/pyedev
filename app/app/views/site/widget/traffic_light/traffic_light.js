
function Refresh{{ @uid }}() {
    $.ajax({
        url: "/widget/{{ @widget_name }}/{{ @metric_name }}/1",
        success: function (data) {
        $('#widget{{ @uid }}').html(data);
        setTimeout(Refresh{{ @uid }}, 10000);
        }
    });
}
setTimeout(Refresh{{ @uid }}, 10000);




