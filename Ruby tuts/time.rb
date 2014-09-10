#Time Class in Ruby

#Find out when I turn 1 billion seconds

puts 'Hello. Let\'s find out when you will be 1 billion seconds old.' 
puts 'Start with entering your birth year: '

year = Integer(gets.chomp) rescue nil

while year == nil
	puts 'This is not a year.'
	year = Integer(gets.chomp) rescue nil
end

puts 'Ok, now enter the month: '
month = Integer(gets.chomp) rescue nil

while month == nil || (month < 1 || month > 12)
	puts 'This can\'t be right.'
	month = Integer(gets.chomp) rescue nil
end

puts 'Good good. Just the day left: '
day = Integer(gets.chomp) rescue nil

while day == nil || (day < 1 || day > 31)
	puts 'This can\'t be right.'
	day = Integer(gets.chomp) rescue nil
end

birthday = Time.mktime(year, month, day, 0, 0)

billion_day = birthday + 1000000000

puts 'Born on : ' + birthday.to_s
puts 'You turn 1 billion seconds on: ' + billion_day.to_s