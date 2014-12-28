# The Odin Project
# Ruby Tutorial > Building Blocks
# Substrings Problem

#!/usr/bin/env ruby

def substrings(str, dict)

	# call downcase only once here
	str.downcase!

	dict_h = Hash.new(0)

	# nested loops :( -> O(n²)
	dict.each do |word|

		# generate key for hash
		key = word.downcase
		dict_h[key] if !dict_h.has_key? key

		# iterate over str to search instances of word
		(0..str.length - 1).each do |i|

			substr = str[i, word.length]
			dict_h[substr] += 1 if word.eql? substr
		end
	end

	return dict_h
end

# >>>> Examples from exercise
str = "Howdy partner, sit down! How's it going?"
dict = ["below","down","go","going","horn","how","howdy",
	"it","i","low","own","part","partner","sit"]

substring_count = substrings("below", dict)
puts substring_count.inspect

substring_count = substrings(str, dict)
puts substring_count.inspect

