function story_blur() {
  
  var content = $(this).val().replace(/\n/g, "<br>")
  var paragraph = "<p class='editable'>" + (content.length == 0 ? 'No Content' : content) + "</p>"
  $(this).after(paragraph)
  $(this).parent().children("p.editable").click(story_click)

  var url = $(this).parent().attr('action')
  $(this).parent().children(".editable_area").remove()
  
  var post_data = '_method=PUT&story[title]=' + $(this).val()
  $.post(url, post_data)
 }
 
function story_click() {
   var textarea = $("<textarea class='editable_area'>" + $(this).html().replace(/<br>/g, "\n") + "</textarea>")
   $(this).after(textarea)
   textarea.autoResize();
   textarea.focus()
   textarea.select()
   textarea.blur(story_blur)
   $(this).remove()
 }

 function column_blur() {
   var content = $(this).val()
   var heading = "<h3 class='column_editable'>" + (content.length == 0 ? 'No Content' : content) + "</h3>"
   $(this).after(heading)
   $(this).parent().children("h3.column_editable").click(column_click)

   var url = $(this).parent().attr('action')
   $(this).parent().children(".editable_area").remove()

   var post_data = '_method=PUT&column[title]=' + $(this).val()
   $.post(url, post_data)
  }

 function column_click() {
    var input = $("<input type=\"text\" class='editable_area' value=\"" + $(this).html() + "\"></input>")
    $(this).after(input)
    input.focus()
    input.select()
    input.blur(column_blur)
    input.keypress(function(event) {
      if (event.keyCode == 13) {
        event.stopPropagation();
        input.blur()
      }
    });
    $(this).remove()
  }

function enable_edit(editable_text) {
  editable_text.click(story_click)
}

function add_story() {
  var new_story = $('.new_story').clone()
  new_story.removeClass('new_story')
  $('first_column').append(new_story)  
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
  $('.column_editable').click(column_click)
  $('a#add_story').click(add_story)
  
});