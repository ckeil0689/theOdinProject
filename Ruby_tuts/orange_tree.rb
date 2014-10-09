#Quick OrangeTree class example (likely has a few bugs left)
class OrangeTree

	def initialize
		@height = 0
		@age = 0
		@fruit_num = 0
		@alive = true
		@max_age = Random.rand(10..30)
	end

	#returns the current height of the tree
	def height
		return @height
	end

	#get number of oranges
	def countTheOranges
		return @fruit_num
	end

	def getAge
		return @age
	end

	#take an orange from the tree
	def pickAnOrange
		if @fruit_num == 0 and @age < 5
			puts 'No oranges have grown yet!'

		elsif @fruit_num > 0
			@fruit_num -= 1
			puts 'Hmmm, a delicious orange!'

		else
			puts 'The tree has no more oranges!'
		end
	end

	#tree change when a year passes
	def oneYearPasses

		fallOff

		@age += 1
		
		if @age > @max_age
			die

		elsif @age > 5
			growFruit @age
		end

		grow
	end

	#checks of tree is still alive
	def is_alive?
		return @alive
	end

	#private methods below
	private

	#tree grows by 1
	def grow 
		@height += 1
	end

	#grows fruit; generally, the older the more
	def growFruit age
		@fruit_num += Random.rand(@age)
	end

	#tree dies
	def die
		puts 'The tree has died.'
		@alive = false
	end

	#all oranges fall off after the year ends.
	def fallOff
		@fruit_num = 0
	end
end

tree = OrangeTree.new

puts 'Tree height: ' + tree.height.to_s

while tree.is_alive?

	puts 'A new year!'

	choice = 'y'
	while choice != 'n'
		
		puts 'Pick orange? (y/n)'
		choice = gets.chomp.downcase
		if choice == 'y'
			tree.pickAnOrange
		end
	end

	tree.oneYearPasses

	puts 'The tree is ' + tree.getAge.to_s + ' years old.' 
	puts 'The tree has ' + tree.countTheOranges.to_s + ' oranges.'
end