function add_task() {
    var form = document.forms['add_task_form'];
    var task_id = form.elements['task_id'].value;
    var group = form.elements['group'].value;

    $.ajax({
        type: 'put',//тип запроса: get,post либо head
        url: '../tasks_groups/'+group+'/add_task.json',//url адрес файла обработчика
        data: { task_id: task_id },//параметры запроса
        response: 'text',//тип возвращаемого ответа text либо xml
        success: function (data) {//возвращаемый результат от сервера
            document.getElementById('alert-info').innerHTML =
                '<div class="alert alert-info alert-dismissable">' +
                    '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>' +
                data.msg + '</div>';
        }
    });
}
