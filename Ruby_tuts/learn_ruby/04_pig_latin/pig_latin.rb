def translate(phrase)

	words = phrase.split(" ")

	suffix = "ay"

	words.map! { |i|

		hasQu = i[0, 3].include? "qu"

		# Regex Checks
		threeCons = i[0, 3] =~ /[^aioue]{3}/   		# three consonants 
		consAndQu = i[0, 3] =~ /[^aioue]qu/			# consonant + qu
		twoCons = i[0, 3] =~ /[^aioue]{2}[aioue]/ 	# two consonants
		oneCons = i[0, 2] =~ /[^aioue][aioue]/ 		# one consonant

		if(threeCons != nil || consAndQu != nil)
			i[3, i.length] + i[0, 3] + suffix

		elsif((twoCons != nil) || hasQu)
			i[2, i.length] + i[0, 2] + suffix

		elsif(oneCons != nil)
			i[1, i.length] + i[0] + suffix

		elsif(oneCons == nil)
			i + suffix
		else
			i
		end
	}

	return words.join(" ")
end

