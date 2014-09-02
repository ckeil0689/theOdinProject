var check35 = function () {

	var num = document.getElementById('enteredNum_P1').value;
	var sum = 0;
	var count = 0;

	while(count < num) {

		count++;

		if(count % 3 === 0 || count % 5 === 0) {
			sum += count;
		}
	}

	document.getElementById('P1_result').innerHTML = sum;
}