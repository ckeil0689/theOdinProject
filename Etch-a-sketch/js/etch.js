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

	$('.paint').css('opacity', 1);

	$('.paint').hover(function() {
		
		switch($('input[name=radios]:checked').val()) {

			case '0': 	pencil($(this));
						break;

			case '1': 	rainbow($(this));
						break;

			case '2': 	asteroid($(this));
						break;

			default: $(this).css('background', '#aaa');
		}
	}, function() {

		if($('input[name=radios]:checked').val() === '2') {
			$(this).animate({opacity: 0}, 800);
			$(this).css('background', '#aaa'); //smoke color
		}
	});
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

// Drawing modes
var pencil = function(element) {

	element.css('background', '#333');

	var opc = parseFloat(element.css('opacity')); // get current opacity

	if(opc === 1.0) {
		element.css('opacity', 0.1);

	} else {		
		opc = parseFloat(element.css('opacity')) + 0.1;
		element.css('opacity', opc);
	}
};

var rainbow = function(element) {
		
	var hex = '#'+(Math.random()*0xFFFFFF<<0).toString(16);
	element.css('background', hex);
};

var asteroid = function(element) {

	element.css('background', '#FFE510');
	element.css('opacity', '1');
};

//Handle-window resize to get a new canvas size
var doit;
window.onresize = function() {
    
    clearTimeout(doit);
    doit = setTimeout(function() {
       resetCanvas();
    }, 100);
};