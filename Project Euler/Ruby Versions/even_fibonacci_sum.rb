
def even_fibonacci_sum(number, sum)

	return sum if number == 1

	sum += number if number % 2 == 0

	p 'F: ' + number.to_s

	return number + even_fibonacci(number, sum)
end

p 'Enter a number to calculate the sum of all even numbers in the Fibonacci sequence.'
input = gets.chomp.to_i

p 'The sum is: ' + even_fibonacci_sum(input, 0).to_s

