$(document).ready(function(){
	$('#addnewuser').click(function() {
		var email = $('#newuseremail').val();
		$.post('adduser', { email: email }, function(data) {
			$('#users').append(data);
		});
	});
});