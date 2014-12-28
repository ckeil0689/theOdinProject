def stock_picker(prices)

	days = [0, 0]
	diff = 0

	# naive, O(n^2) for now... 
	prices.each_with_index do |price, index|

		# low cannot be set after high!
		prices[index, prices.length].each_with_index do |price2, index2|

			#puts "Price: #{price} - Price2: #{price2}"

			if price2 - price > diff
				diff = price2 - price
				days[0] = index
				days[1] = index2 + index # we started at index, not 0!
			end
		end
	end

	puts days.inspect

end

stock_picker([17,3,6,9,15,8,6,1,10])

stock_picker([21,23,3,9,1,8,16,1,2])