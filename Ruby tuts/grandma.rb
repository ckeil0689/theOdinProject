puts 'Say something to your grandma!'

input = gets.chomp
bye_amount = 0

while bye_amount != 3

	if input != input.upcase
		puts 'HUH?!  SPEAK UP, SONNY!'
	else
		random_year = rand(1930 .. 1951)
		puts 'NOT SINCE ' + random_year.to_s + '!'
	end
	
	input = gets.chomp
	if input == 'BYE'
		bye_amount += 1
		puts 'I CAN\'T FLY...'
	else
		bye_amount = 0
	end
end

puts 'SEE YA LATER!'