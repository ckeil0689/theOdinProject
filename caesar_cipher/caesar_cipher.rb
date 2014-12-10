def caesar_cipher(text, shift_num)

	# ASCII table bounds
	ascii_A = 65
	ascii_Z = 90
	ascii_a = 97
	ascii_z = 122

	text.split("").each_with_index do |char, index|

		ascii = char.ord

		# is char in alphabet in ascii table? 
		isCapitalLetter =  ascii >= ascii_A && ascii <= ascii_Z
		isSmallLetter = ascii >= ascii_a && ascii <= ascii_z

		if isCapitalLetter || isSmallLetter

			shifted_ascii = ascii + shift_num

			# adjust when passing ascii boundaries
			if shifted_ascii > ascii_z
				translate = shifted_ascii - ascii_z
				shifted_ascii = (ascii_a - 1) + translate

			elsif shifted_ascii < ascii_A
				translate = ascii_A - shifted_ascii
				shifted_ascii = (ascii_Z + 1) - translate

			elsif shifted_ascii > ascii_Z && ascii <= ascii_Z
				translate = shifted_ascii - ascii_Z
				shifted_ascii = (ascii_A - 1) + translate

			elsif shifted_ascii < ascii_a && ascii >= ascii_a
				translate = ascii_a - shifted_ascii
				shifted_ascii = (ascii_z + 1) - translate

			end


			text[index] = shifted_ascii.chr
		end

	end

	return text
end


puts caesar_cipher("De bello gallico", 5)