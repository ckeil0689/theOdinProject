start = 99
temp = start

while start > 0

	puts temp.to_s + 'bottles of beer on the wall, ' + temp.to_s + ' bottles of beer.'

	if start == 1
		temp = 'no'
		start = 0
	else
		start += -1
		temp = start
	end
	puts 'Take one down and pass it around, ' + temp.to_s + ' bottles of beer on the wall.'
end

puts 'No more bottles of beer on the wall, no more bottles of beer. 
Go to the store and buy some more, 99 bottles of beer on the wall.'