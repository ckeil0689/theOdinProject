#Problems - Lexographic Sort

#Sorting - should probably make it use less nested loops one day....
#Also still fails tests when factoring in length of compared words
# ---> 'cfe' comes before 'co'
def sort_words(words)

	sorted_words = []

	goal = words.length #check when sorted_words is the same size as original

	while sorted_words.length < goal

		#Take word from words
		for word in words do

			#check against remaining words
			for j in 0..words.length - 1

				compare = words[j]

				puts "Word: " + word + ' & Compare: ' + compare

				#More nesting to check chars
				limit = 0
				if word.length < compare.length
					limit = word.length - 1
				else 
					limit = compare.length - 1
				end

				for k in 0..limit

					if compare[k] < word[k]
						word = compare
						break
					end
				end
			end

			words.delete(word)
			sorted_words << word

			#Debug prints
			# puts 'Words: ' + words.to_s
			# puts 'Sorted Words: ' + sorted_words.to_s
			# puts '-------------------------------'
		end
	end
		return sorted_words
end

puts 'Write as many words as you like. To finish, press Enter on an empty line.'

words = []

typing = true

while typing
	input = gets.chomp.downcase
	if(input.length > 0)
		words << input
	else
		typing = false
	end
end

puts 'Want to use sort method? (y/n)'

asking = true

while asking
	choice = gets.chomp.downcase

	if choice === 'y'
		puts 'Your sorted words: ' + words.sort.to_s
		asking = false
	elsif choice === 'n'

		puts 'Your sorted words: ' + sort_words(words).sort.to_s

		asking = false
	else
		puts 'Typo? This answer is not valid. Use \'y\' or \'n\'.'
	end
end

