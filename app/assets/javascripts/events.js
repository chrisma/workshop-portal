// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(function() {

    $('#send-emails-modal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var header = button.data('title');
        var list = button.data('list');
        var modal = $(this);
        modal.find('.modal-title').text(header);
        modal.find('#send-emails-mailto').attr('href', 'mailto:' + list);
        modal.find('#send-emails-list').val(list);
    });

    var users = $('#users');
    var groups = $('#groups');

    $('#all').change(function(event) {
        var method = event.target.checked ? 'select_all' : 'deselect_all';
        users.multiSelect(method);
        groups.multiSelect(method);
    });

    var unable_all_on_deselect = function() {
        $('#all').attr('checked', false);
    };

    users.multiSelect({
        afterDeselect: unable_all_on_deselect
    });
    groups.multiSelect({
        afterDeselect: unable_all_on_deselect
    });
});

function addEventDatePicker() {
  var picker = $('#event-add-date-picker');

  $(EVENT_DATE_PICKER_TEMPLATE)
    .insertBefore(picker);

  enableDatepickers();
}

function removeEventDatePicker(button) {
  $(button).parent('div').remove();
}

function flipAllCheckboxes(rootCheckbox) {
  if (rootCheckbox.checked) {
    jQuery(':checkbox.'.concat(rootCheckbox.className)).each(function() {
      this.checked = true;
    });
  } else {
    jQuery(':checkbox.'.concat(rootCheckbox.className)).each(function() {
      this.checked = false;
    });
  }
}
