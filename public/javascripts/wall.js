function story_blur() {
   var paragraph = "<p class='editable'>" + $(this).val().replace(/\n/g, "<br>") + "</p>"
   $(this).after(paragraph)
   $(this).parent().children("p.editable").click(story_click)
   
   var url = $(this).parent().attr('action')
   var post_data = '_method=PUT&story[title]=' + $(this).val()
   $.post(url, post_data)
   
   $(this).remove()
 }
 
function story_click() {
   var textarea = $("<textarea class='editable_area'>" + $(this).html().replace(/<br>/g, "\n") + "</textarea>")
   $(this).after(textarea)
   textarea.autogrow();
   textarea.focus()
   textarea.blur(story_blur)
   $(this).remove()
 }

function enable_edit(editable_text) {
  editable_text.click(story_click)
}

$(document).ready(function() {
  for (var i in column_ids) {
    $(column_ids[i]).sortable({
      placeholder: 'highlight',
      forcePlaceholderSize: true,
      connectWith: '.sortable',
      
      start: function(event, ui) {
        $(ui.item).children('form').children('p.editable').unbind('click')
      },
      
      stop: function(event, ui) {        
        editable_text = $(ui.item).children('form').children('p.editable')
        window.setTimeout(enable_edit, 1, editable_text);
        
        var index = $(ui.item).parent().children().index(ui.item)
        var story_id = $(ui.item).attr('id')
        var old_column_id = $(event.target).attr('id').replace('column_', '');
        var new_column_id = $(ui.item).parent().attr('id').replace('column_', '');
        var url = '/walls/' + wall_name + '/columns/' + old_column_id + '/stories/' + story_id
        var post_data = '_method=PUT&story[index]=' + index + '&story[column_id]=' + new_column_id
        $.post(url, post_data, function(data) {
        });
      }
    });
    
    $(column_ids[i]).disableSelection();
  }
  
  $('p.editable').click(story_click)
  
});