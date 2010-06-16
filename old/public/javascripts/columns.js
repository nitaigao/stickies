$(document).ready(function(){
	var columns = $('.column')
	columns.each(function(index, column) {
		column = $(column)
		var maxWidth = $('.columns').width() / columns.size()
		maxWidth -= parseFloat(column.css("margin-left"))
		maxWidth -= parseFloat(column.css("margin-right"))
		maxWidth -= parseFloat(column.css("padding-left"))
		maxWidth -= parseFloat(column.css("padding-right"))
		
		var percent = ((maxWidth / $('.columns').width()) * 100) - 1
		column.width(percent + '%')
	});
	
	
	$(".story").draggable({ revert: 'invalid' });
	$(".column").droppable({
		hoverClass: 'column-drop-hover',
		drop: function(event, ui) {
			$.ajax({
			          type: "PUT",
			          url: '/stories/' + ui.draggable.attr('id'),
			          data: { story: { "column_id": $(this).attr('id') } },
			          dataType: 'json',
			          success: function(msg) {
			          }
			});
		}
	});
	
});