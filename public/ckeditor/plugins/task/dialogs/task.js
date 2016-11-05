CKEDITOR.dialog.add('task', function(editor) {
    return {
        title : 'Добавление блока с задачей',
        minWidth : 400,
        minHeight : 200,
        onOk: function() {
            var tabId = this.definition.dialog._.currentTabId;
            if(tabId == 'task') {
                var taskValue = this.getContentElement('task', 'taskValue').getInputElement().getValue();
                var taskName = this.getContentElement('task', 'taskName').getInputElement().getValue();
                $.ajax({
                    type: 'get',//тип запроса: get,post либо head
                    url: '../tasks/' + taskValue + '.json',//url адрес файла обработчика
                    data: {},//параметры запроса
                    response: 'text',//тип возвращаемого ответа text либо xml
                    success: function (data) {//возвращаемый результат от сервера
                        var element = CKEDITOR.dom.element.createFromHtml(
                            '<div class="task" task_id="' + taskValue + '" task_name="' + taskName + '" data-title="Блок с задачей № ' + taskName + ': ' + data.title + '">' +
                            '<p>' + data.task + '</p>' +
                            '</div>'
                        );
                        editor.insertElement(element);
                    }
                });
            } else {
                var groupValue = this.getContentElement('group', 'groupValue').getInputElement().getValue();
                var taskName = this.getContentElement('group', 'taskName').getInputElement().getValue();
                $.ajax({
                    type: 'get',//тип запроса: get,post либо head
                    url: '../tasks_groups/'+groupValue+'.json',//url адрес файла обработчика
                    data: {},//параметры запроса
                    response: 'text',//тип возвращаемого ответа text либо xml
                    success: function (data) {//возвращаемый результат от сервера
                        var element = CKEDITOR.dom.element.createFromHtml(
                            '<div class="task" tasks_group_id="'+groupValue+'" task_name="'+taskName+'" ' +
                            'data-title="Блок с задачей № '+taskName+' из группы: '+data.title+'">' +
                                '<p>' + data.tasks[0].task + '</p>' +
                            '</div>'
                        );
                        editor.insertElement(element);
                    }
                });
            }
        },
        contents : [{
                id : 'task',
                label : 'Задача',
                title : 'Задача',
                elements : [
                    {
                        id : 'taskName',
                        type : 'text',
                        label: 'Идентификатор (номер) задачи'
                    },
                    {
                        id : 'taskValue',
                        type : 'select',
                        items: [],
                        label: 'Задача'
                    }
                ]
            },
            {
                id : 'group',
                label : 'Группа задач',
                title : 'Группа задач',
                elements : [
                    {
                        id : 'taskName',
                        type : 'text',
                        label: 'Идентификатор (номер) задачи'
                    },
                    {
                        id : 'groupValue',
                        type : 'select',
                        items: [],
                        label: 'Группа задач'
                    }
                ]
            }],
        onShow: function() {
            var dialog = this;
            $.ajax({
                type:'get',//тип запроса: get,post либо head
                url:'../tasks/my_tasks.json',//url адрес файла обработчика
                data:{},//параметры запроса
                response:'text',//тип возвращаемого ответа text либо xml
                success:function (data) {//возвращаемый результат от сервера
                    var taskValue = dialog.getContentElement( 'task', 'taskValue');
                    taskValue.clear();
                    titles = data.value.forEach(function(task) { taskValue.add( task.title, task.id); });
                }
            });
            $.ajax({
                type:'get',//тип запроса: get,post либо head
                url:'../tasks_groups/my_groups.json',//url адрес файла обработчика
                data:{},//параметры запроса
                response:'text',//тип возвращаемого ответа text либо xml
                success:function (data) {//возвращаемый результат от сервера
                    var groupValue = dialog.getContentElement( 'group', 'groupValue');
                    groupValue.clear();
                    titles = data.value.forEach(function(group) { groupValue.add( group.title, group.id); });
                }
            });
        }
    };
});