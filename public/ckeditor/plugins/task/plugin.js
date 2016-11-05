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

    CKEDITOR.dialog.add('task', this.path + 'dialogs/task.js');
  }
});
