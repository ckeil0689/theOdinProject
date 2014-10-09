def multiples35(number)

	sum = 0
	(0..number).each do |n|
		sum += n if (n % 3 == 0 || n % 5 == 0)
	end
	return sum
end

p 'Enter a number X to find out the sum of all natural numbers between 0 and X that are divisible by 3 or 5.'
input = gets.chomp.to_i

p 'The sum is ' + multiples35(input).to_s

