function story_blur() {
  var column_id = $(this).parents('ul').attr('id').replace('column_', '')
  var post_url = '/walls/' + wall_name + '/columns/' + column_id + '/stories/'
  
  var story = $(this).parents('li')
  var story_id = story.attr('id')
  var put_url = '/walls/' + wall_name + '/columns/' + column_id + '/stories/' + story_id
  
  var is_empty_story = $(this).parents('li').hasClass('empty_story')
  var url = (is_empty_story) ? post_url : put_url
  var method = (is_empty_story) ? "POST" : "PUT"
  
  var post_data = '_method=' + method + '&story[title]=' + $(this).val()
  $.post(url, post_data, function(data) {
    story.attr('id', data.id)
    story.removeClass('empty_story')
  })
  
  var content = $(this).val().replace(/\n/g, "<br>")
  $(this).parent().click(story_click)
  $(this).parent().html(content)
 }
 
function story_click() {
  $('.editable_area').blur()
  $(this).unbind('click')
  var textarea = $("<textarea class='editable_area'>" + $(this).html().replace(/<br>/g, "\n") + "</textarea>")
  $(this).html(textarea)
  textarea.autoResize();
  textarea.blur(story_blur)
  textarea.focus()
  textarea.select()
}

 function column_blur() {
   var content = $(this).val()
   var heading = "<h3 class='column_editable'>" + (content.length == 0 ? 'No Content' : content) + "</h3>"
   $(this).after(heading)
   $(this).parent().children("h3.column_editable").click(column_click)
   
   var post_url = '/walls/' + wall_name + '/columns/'

   var column = $(this).parents('td')

   var column_id = column.attr('id').replace("column_", "")
   var put_url = '/walls/' + wall_name + '/columns/' + column_id

   var is_empty_column = $(this).parents('div').hasClass('empty_column')
   var url = (is_empty_column) ? post_url : put_url
   var method = (is_empty_column) ? "POST" : "PUT"
 
   var post_data = '_method=' + method + '&column[title]=' + $(this).val()
   $.post(url, post_data, function(data) {
     column.attr('id', 'column_' + data.id)
     column.removeClass('empty_column')
   })

   $(this).parent().children(".editable_area").remove()
  }

 function column_click() {
    var input = $("<input type=\"text\" class='editable_area' value=\"" + $(this).html() + "\"></input>")
    $(this).after(input)
    $(this).remove()
    input.focus()
    input.select()
    input.blur(column_blur)
    input.keypress(function(event) {
      if (event.keyCode == 13) {
        event.stopPropagation();
        input.blur()
      }
    });
  }

function enable_edit(editable_text) {
  editable_text.click(story_click)
}

function add_story(event) {  
  var new_story = $($('.new_story').html())
  $('.column_left').find('.sortable').append(new_story)
  new_story.find('.story_editable').click(story_click)
  new_story.find('.story_editable').click()
  return false
}

function add_column(event) {
  var column = $("<td></td>").addClass("column max_height")

  var new_column = $('.new_column')
  column.append(new_column.html())

  $('#last_column').before(column)
  make_sortable(column.find("ul"))
  
  var width = 100 / $(".column").size()
  var max_width = 25
  
  $(".column").attr("style", "width: " + (width > max_width) ? max_width : width + "%")
  $(".column").removeClass("column_left").removeClass("column_right")
  $(".column").last().addClass("column_right")
  $(".column").first().addClass("column_left")

  column.find('.column_editable').click(column_click)
  column.find('.column_editable').click()
  
  return false
}

function make_sortable(column) {
  $(column).sortable({
    placeholder: 'highlight',
    forcePlaceholderSize: true,
    connectWith: '.sortable',
    
    start: function(event, ui) {
      $(ui.item).children('form').unbind('click')
    },
    
    stop: function(event, ui) {
      editable_text = $(ui.item).children('form')
      window.setTimeout(enable_edit, 1, editable_text);
      
      var index = $(ui.item).parent().children().index(ui.item)
      var story_id = $(ui.item).attr('id')
      var old_column_id = $(event.target).attr('id').replace('column_', '');
      var new_column_id = $(ui.item).parent().attr('id').replace('column_', '');
      
      var url = '/walls/' + wall_name + '/columns/' + old_column_id + '/stories/' + story_id
      var post_data = '_method=PUT&story[index]=' + index + '&story[column_id]=' + new_column_id
      $.post(url, post_data);
    }
  });
  
  $(column).disableSelection();
}

$(document).ready(function() {
  $(".sortable").each(function(i, sortable) {
    make_sortable($(sortable))
  });
  
  $('.story_editable').click(story_click)
  $('.column_editable').click(column_click)
  $('a#add_story').click(add_story)
  $('a#add_column').click(add_column)
  
});