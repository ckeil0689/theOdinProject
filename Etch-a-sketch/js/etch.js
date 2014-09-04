$(document).ready(function() {
	
	$('#startBtn').click(function() {

		$('#initial').remove();
		$('#header').show();
		$('#canvas').show();
		$('#resetBtn').show();

		var cw = $('#container').width() - 20;
		var ch = $('#container').height() - 100;


		//Assume 15px width + height per element (10 size, 2 margin)
		var xNum = Math.floor(cw/12);
		var yNum = Math.floor(ch/12);

		var divNum = xNum * yNum;

		for(var i = 0; i < divNum; i++) {

			$('#canvas').append("<div class='untouched'></div>");
		}

		$('div .untouched').hover(function() {
			
			var hex = '#'+(Math.random()*0xFFFFFF<<0).toString(16);
			$(this).css('background', hex);

		}, function() {

		});
	});

	$('#resetBtn').click(function() { 

		$('div .untouched').css('background', '#fff');
	});
});