class Book

	@@title
	@@conjunctions

	# Sets the title and conjunctions
	def title=(word) 

		@title = word
		@nonCapWords = ["and", "or", "the", "in", "on", "of", "a", "an"]

	end

	# Capitalizes all words in title excluding exceptions
	def title() 

		@title = @title.split(" ").each_with_index.map {|word, i| 
			
			if(@nonCapWords.include?(word) && i != 0) 
				word
			else
				word.capitalize
			end

			}.join(" ")
	end

end