/**
 * @license Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';

	// Говорим CKEditor, что нужно загрузить наш плагин
	config.extraPlugins = 'task';
	// config.extraAllowedContent = 'task[task_id]';
	config.allowedContent = true;

	config.toolbarGroups = [
		{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
		{ name: 'forms', groups: [ 'forms' ] },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		'/',
		{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
		{ name: 'links', groups: [ 'links' ] },
		{ name: 'insert', groups: [ 'insert' ] },
		'/',
		{ name: 'styles', groups: [ 'styles' ] },
		{ name: 'colors', groups: [ 'colors' ] },
		{ name: 'tools', groups: [ 'tools' ] },
		{ name: 'others', groups: [ 'others' ] },
		{ name: 'about', groups: [ 'about' ] },
		{ name: 'card', groups: [ 'task' ] }
	];

	config.removeButtons = 'Source,Save,NewPage,Preview,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Flash';

	config.filebrowserImageBrowseUrl = '/images';
	config.filebrowserImageUploadUrl = '/images?'+$('meta[name="csrf-param"]').attr('content')+'='+encodeURIComponent($('meta[name="csrf-token"]').attr('content'));
};
