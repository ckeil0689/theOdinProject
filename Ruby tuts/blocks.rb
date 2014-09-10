#Grandpa Clock

def ring description, &block

	#in 12hr format
	hours = Time.now.hour

	if hours > 12
		hours -= 12
	end

	puts hours.to_s + description

	hours.times do
		block.call
	end
end 

puts 'Grandpa Clock: '

ring ' hours' do 

	puts 'Dong!'
end

#Program Logger
$nesting_depth = -1
puts 'Logger:'
def log description, &block

	$nesting_depth += 1
	space = '  ' * $nesting_depth
	puts space + 'Beginning ' + description + '...'

	block_result = block.call

	puts space + 'Finished ' + description
	puts space + 'Result: ' + block_result.to_s
end

#calling method
log 'outer block' do

	#Block 1
	log 'inner block' do

		# Block 2
		log 'black hole block' do
			
			#Block 3
			'infinity'
		end

		'Love beer!'
	end

	'Love bacon!'
end



