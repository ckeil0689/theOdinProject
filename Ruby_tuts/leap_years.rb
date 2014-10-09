puts 'Enter a start year: '
start_year = gets.chomp.to_i

puts 'Enter an end year: '
end_year = gets.chomp.to_i

#Should check if inputs are valid

year = start_year

while year <= end_year

	if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
		puts year.to_s
	end 
	year += 1
end