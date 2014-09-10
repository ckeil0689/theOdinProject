#Grandpa Clock

def ring description, &block

	#in 12hr format
	hours = Time.now.hour

	puts hours.to_s + description

	hour.times block.call
end 

ring ' hours' do 

	puts 'Dong!'
end