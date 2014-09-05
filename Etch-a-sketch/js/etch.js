// To account for space not used by #canvas in #container
var wAdjust = 20;
var hAdjust = 100;

// Initial dimensions
var cw = $('#container').width() - wAdjust;
var ch = $('#container').height() - hAdjust;

$(document).ready(function() {
	
	$('#startBtn').click(function() {

		$('#initial').remove();
		$('#header').show();
		$('#selectStyle').show();
		makeGrid(cw, ch);

		$('#canvas').show();
		$('#reset').show();
		setCanvas();
	});

	$('#resetBtn').click(function() { 
		resetCanvas();
	});

	$('.radio').click(function() { 
		
		resetCanvas();
	});
});

var resetCanvas = function() {

	var checkW = $('#container').width() - wAdjust;
	var checkH = $('#container').height() - hAdjust;

	if(checkW !== cw || checkH !== ch) {

		cw = checkW;
		ch = checkH;
		
		$('#canvas').empty();
		makeGrid(cw, ch);

	} else {
		clearGrid();
	}

	setCanvas();
};

var setCanvas = function() {

	var option = $('input[name=radios]:checked').val();

	switch(option) {

		case '0': 	pencil();
					break;

		case '1': 	rainbow();
					break;

		case '2': 	asteroid();
					break;

		default: $(this).css('background', '#aaa');
	}
};

var clearGrid = function() {

	$('.paint').css('background', '#fff');
};

var makeGrid = function(cwidth, cheight) {

	var dim = 22; //element side length + margin
	var xNum = Math.floor(cwidth/dim);
	var yNum = Math.floor(cheight/dim);

	var divNum = xNum * yNum;

	var treasureNum = 0;
	var $canvas = $('#canvas');
	for(var i = 0; i < divNum; i++) {

		$canvas.append("<div class='paint'></div>");
	}
};

var pencil = function() {

	$('.paint').hover(function() {
		
		$(this).css('background', '#aaa');

	}, function() {

	});
};

var rainbow = function() {

	$('.paint').hover(function() {
		
		var hex = '#'+(Math.random()*0xFFFFFF<<0).toString(16);
		$(this).css('background', hex);

	}, function() {

	});
};

var asteroid = function() {

	$('.paint').hover(function() {
		
		$(this).css('background', '#FFE510');
		$(this).css('opacity', '1');

	}, function() {

		$(this).animate({opacity: 0, background: '#FFE5A3'}, 800);
	});
};

//Handle-window resize to get a new canvas size
var doit;
window.onresize = function() {
    
    clearTimeout(doit);
    doit = setTimeout(function() {
       resetCanvas();
    }, 100);
};