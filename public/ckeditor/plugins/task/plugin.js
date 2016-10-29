CKEDITOR.plugins.add('task', {
  init : function(editor) {
    var command = editor.addCommand('task', new CKEDITOR.dialogCommand('task'));
    command.modes = {wysiwyg:1, source:1};
    command.canUndo = true;

    editor.ui.addButton('Task', {
      label : 'Добавить задачу в билет',
      command : 'task',
      title: 'Добавить задачу',
      icon: '../images/icons/task.png'
    });


    // Доабавляю диалог
    var titles = [];
//отправляю GET запрос и получаю ответ
    $.ajax({
      type:'get',//тип запроса: get,post либо head
      url:'../tasks/my_tasks.json',//url адрес файла обработчика
      data:{},//параметры запроса
      response:'text',//тип возвращаемого ответа text либо xml
      success:function (data) {//возвращаемый результат от сервера
        var tasks = data.value;
        titles = data.value.map(function(task) { return [task.title, task.id]; });
        CKEDITOR.dialog.add('task', function(editor) {

          return {
            title : 'Добавить задачу',
            minWidth : 400,
            minHeight : 200,
            onOk: function() {
              var taskValue = this.getContentElement( 'task', 'taskValue').getInputElement().getValue();
              $.ajax({
                type: 'get',//тип запроса: get,post либо head
                url: '../tasks/'+taskValue+'.json',//url адрес файла обработчика
                data: {},//параметры запроса
                response: 'text',//тип возвращаемого ответа text либо xml
                success: function (data) {//возвращаемый результат от сервера
                  var element = CKEDITOR.dom.element.createFromHtml(
                      '<div class="task" task_id="' + taskValue + '">' +
                          '<b>Блок задачи: ' + data.title + '</b> <hr>' +
                          '<p>' + data.task + '</p>' +
                      '</div>'
                  );
                  editor.insertElement(element);
                }
              });
            },
            contents : [{
              id : 'task',
              label : 'First Tab',
              title : 'First Tab',
              elements : [{
                id : 'taskValue',
                type : 'select',
                items: titles,
                label: 'Задача'
              }]
            }]
          };
        });
      }
    });

    CKEDITOR.dialog.add('task', this.path + 'dialogs/task.js');
  }
});
