# The Odin Project
# Ruby Tutorial > Building Blocks
# Substrings Problem

#!/usr/bin/env ruby

def substrings(string, dictionary)

	dict_h = Hash.new(0)

	# nested loops :(
	dictionary.each do |word|

		# generate key for hash
		dict_h[word.downcase] if !dict_h.has_key?

		# iterate over string to search instances of word
		(0..string.length - 1).each do |i|

			substr = string[i, word.length].downcase

			if word.eql? substr
				dict_h[substr] += 1
			end
		end
	end

	return dict_h
end

# >>>> Examples from exercise
string = "Howdy partner, sit down! How's it going?"
dictionary = ["below","down","go","going","horn","how","howdy",
	"it","i","low","own","part","partner","sit"]

substring_count = substrings("below", dictionary)
puts substring_count.inspect

substring_count = substrings(string, dictionary)
puts substring_count.inspect

