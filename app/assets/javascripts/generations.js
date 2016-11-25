function get_html(el_id, link) {
    var el = document.getElementById(el_id);
    var status = el.getElementsByClassName('view-status')[0];
    status.innerHTML = '<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>';
    $.ajax({
        type: 'get',                                    //тип запроса: get,post либо head
        url: link,                                      //url адрес файла обработчика
        data: {},                                       //параметры запроса
        response: 'text',                               //тип возвращаемого ответа text либо xml
        success: function (data) {                      //возвращаемый результат от сервера
            status.innerHTML = '';
            el.getElementsByClassName('view-result')[0].innerHTML = data;
        }
    });
}

function openGenerateModal(question_card_id) {
    var form = document.forms['form-generator'];
    form.elements['question_card_id'].value = question_card_id;
    $('#generateModal').modal();
}