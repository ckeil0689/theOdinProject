$(document).ready(function() {
	
	$('#startBtn').click(function() {

		$('#initial').remove();
		$('#resetBtn').show();

		var divNum = 16;//$("#divNum :input[name='numGetter'").val();

		for(var i = 0; i < divNum; i++) {

			$('#canvas').append("<div class='untouched'></div>");
		}

		$('div .untouched').hover(function() {
			$(this).removeClass('untouched');
			$(this).addClass('touched');

		}, function() {

		});
	});

	$('#resetBtn').click(function() { 

		$('.touched').removeClass('touched');
	});
});