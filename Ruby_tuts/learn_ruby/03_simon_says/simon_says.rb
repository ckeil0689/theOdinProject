def echo(word)
	return word
end

def shout(word)
	return word.upcase
end

def repeat(word, num = 2)

	repeat = ''

	while (num > 1) do
		repeat += word + " "
		num -= 1
	end

	return repeat + word
end

def start_of_word(word, index) 
	return word[0, index]
end

def first_word(sentence)
	return sentence.split(" ")[0]
end

def titleize(sentence) 

	words = sentence.split(" ")

	newSentence = ''
	index = 0
	while(index < words.length)
		i = words[index]
		i = i.capitalize unless index != 0 && (i == "and" || i == "the" || i == "over")
		newSentence += i + " "
		index += 1
	end

	return newSentence[0, newSentence.length - 1]
end





