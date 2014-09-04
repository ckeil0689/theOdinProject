$(document).ready(function() {
	
	$('#startBtn').click(function() {

		$('#initial').remove();
		$('#header').show();
		$('#selectStyle').show();

		setCanvas();
	});

	$('#resetBtn').click(function() { 
		
		$('#canvas').empty();
		setCanvas();
	});
});

var setCanvas = function() {

	var cw = $('#container').width() - 20;
	var ch = $('#container').height() - 100;

	//Assume 10px width + height per element (8 size, 2 margin)
	var dim = 12;
	var xNum = Math.floor(cw/dim);
	var yNum = Math.floor(ch/dim);

	var divNum = xNum * yNum;

	var treasureNum = 0;
	var $canvas = $('#canvas');
	for(var i = 0; i < divNum; i++) {

		$canvas.append("<div class='paint'></div>");
	}

	$('#canvas').show();
	$('#resetBtn').show();

	$('div .paint').hover(function() {

		var hex = '#'+(Math.random()*0xFFFFFF<<0).toString(16);
		$(this).css('background', hex);

	}, function() {

	});

	// $('div .treasure').hover(function() {

	// 	// window.location='www.reddit.com';

	// }, function() {

	// });
};