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

	$('.radio').click(function() { 
		
		$('#canvas').empty();
		setCanvas();
	});
});

var setCanvas = function() {

	makeGrid();

	$('#canvas').show();
	$('#reset').show();

	var option = $('input[name=radios]:checked').val();

	switch(option) {

		case '0': 	pencil();
					break;

		case '1': 	rainbow();
					break;

		case '2': 	trail();
					break;

		default: $(this).css('background', '#aaa');
	}
};

var makeGrid = function() {

	var cw = $('#container').width() - 20;
	var ch = $('#container').height() - 100;

	
	var dim = 12; //element side length + margin
	var xNum = Math.floor(cw/dim);
	var yNum = Math.floor(ch/dim);

	var divNum = xNum * yNum;

	var treasureNum = 0;
	var $canvas = $('#canvas');
	for(var i = 0; i < divNum; i++) {

		$canvas.append("<div class='paint'></div>");
	}
};

var pencil = function() {

	$('div .paint').hover(function() {
		
		$(this).css('background', '#aaa');

	}, function() {

	});
};

var rainbow = function() {

	$('div .paint').hover(function() {
		
		var hex = '#'+(Math.random()*0xFFFFFF<<0).toString(16);
		$(this).css('background', hex);

	}, function() {

	});
};

var trail = function() {

	$('div .paint').hover(function() {
		
		$(this).css('background', '#aaa');

	}, function() {

	});
};