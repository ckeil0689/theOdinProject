var evenFiboSum = function () {

	var limit = document.getElementById('enteredNum_P2').value;
	var sum = 0;
	var first = 1;
	var second = 2;
  	var temp = 0;

	while(second <= limit) {

		if(second % 2 === 0) {
			sum += second;
		}

    	temp = first;
	  	first = second;
	  	second += temp;
	}

	document.getElementById('P2_result').innerHTML = sum;
}