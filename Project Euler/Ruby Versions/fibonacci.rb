
def fibo_sum(num)

	first = 1
	second = 2
	fibo = 0
	sum = 2

	while fibo < num do

		fibo = first + second

		sum += fibo if fibo % 2 == 0

		first = second
		second = fibo
	end

	return sum
end

p 'Enter a number to calculate the sum of all even numbers in the Fibonacci sequence.'
input = gets.chomp.to_i

p 'The sum is: ' + fibo_sum(input).to_s

