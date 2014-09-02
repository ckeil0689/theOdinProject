var findLargestPrime = function () {

	var limit = document.getElementById('enteredNum_P3').value;
	if(isNaN(limit)) {
		while(isNaN(limit)) {
			limit = prompt("Nope, not a number. Try again:");
		}
	}

	var largestPrime = 0;

	for(var i = 3; i < limit; i+= 2) {

		if(checkPrime(i) && limit % i === 0) {
			largestPrime = i;
		}
	}

	document.getElementById('P3_result').innerHTML = largestPrime;
};

// Helper to find out if a factor is prime
var checkPrime = function(factor) {

	if(factor % 2 === 0) {
		return false;
	}

	var sqrt = Math.ceil(Math.sqrt(factor));

	// Only iterate over non-even numbers
	for(var i = 3; i <= sqrt; i += 2) {

		if(factor % i === 0) {
			return false;
		}
	}

	return true;
};