function add_task() {
    var form = document.forms['add_task_form'];
    var task_id = form.elements['task_id'].value;
    var group = form.elements['group'].value;

    $.ajax({
        type: 'put',//тип запроса: get,post либо head
        url: '/tasks_groups/'+group+'/add_task.json',//url адрес файла обработчика
        data: { task_id: task_id },//параметры запроса
        response: 'text',//тип возвращаемого ответа text либо xml
        success: function (data) {//возвращаемый результат от сервера
            document.getElementById('alert-info').innerHTML =
                '<div class="alert alert-success alert-dismissable">' +
                    '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>' +
                data.notice + '</div>' + document.getElementById('alert-info').innerHTML;
        }
    });
}

function remove_task() {
    var task_id = $(this)[0].getAttribute('task_id');
    var group = $(this)[0].getAttribute('group');

    $.ajax({
        type: 'delete',//тип запроса: get,post либо head
        url: '/tasks_groups/'+group+'/remove_task.json',//url адрес файла обработчика
        data: { task_id: task_id },//параметры запроса
        response: 'text',//тип возвращаемого ответа text либо xml
        success: function (data) {//возвращаемый результат от сервера
            document.getElementById('task_' + task_id).remove();
            document.getElementById('alert-info').innerHTML =
                '<div class="alert alert-info alert-dismissable">' +
                '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>' +
                data.notice + '</div>';
        }
    });
}

function openModalAddTask(task_id) {
    $.ajax({
        type: 'get',//тип запроса: get,post либо head
        url: '/tasks_groups/available_groups_for_add.json',//url адрес файла обработчика
        data: { task_id: task_id },//параметры запроса
        response: 'text',//тип возвращаемого ответа text либо xml
        success: function (data) {//возвращаемый результат от сервера
            var form = document.forms['add_task_form'];
            form.elements['task_id'].value = task_id;
            var selectGroup = form.elements['group'];
            selectGroup.innerHTML = '';
            data.forEach(function (group) {
                var opt =document.createElement('option');
                opt.value = group.id;
                opt.innerHTML = group.title;
                selectGroup.appendChild(opt);
            });
            $('#addTaskModal').modal();
        }
    });
}