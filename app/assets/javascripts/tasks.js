function addVariableForm(list_id) {
    var forms = document.getElementById(list_id);
    var newForm = forms.lastElementChild.cloneNode(true);
    resetVariableForm(newForm, list_id, true);
    forms.appendChild(newForm);
}

function removeVariableForm(el, list_id) {
    if ( document.getElementById(list_id).childElementCount > 1 ) {
        $(el).remove()
    } else {
        resetVariableForm(el, list_id, false);
    }
}

function resetVariableForm(el, list_id, isNew) {
    var i = document.getElementById(list_id).childElementCount;
    if (!isNew) i--;
    var a = el.getElementsByTagName('input');
    [].forEach.call(a, function (input) {
        input.value = '';
        input.name = input.name.replace(/\[\d+(\]\[.+\])$/, '[' + i + '$1');
    });
    a = el.getElementsByTagName('select');
    [].forEach.call(a, function (select) {
        select.value = '';
        select.name = select.name.replace(/\[\d+(\]\[.+\])$/, '[' + i + '$1');
    });
}