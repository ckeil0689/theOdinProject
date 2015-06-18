require 'csv'

def correct_zip(zipcode)

  def_size = 5

  if zipcode.nil? || zipcode.length == 0
    zipcode = '00000'
  elsif zipcode.length < def_size
    until zipcode.length == def_size
        zipcode = '0' + zipcode 
    end
    return zipcode #concat
  end
  return zipcode
end

puts "Event Manager created!"

contents = CSV.open('event_attendees.csv', headers: true, 
  header_converters: :symbol)

contents.each do |row|
  name = row[:first_name]
  zipcode = correct_zip(row[:zipcode])

  puts "#{name}\t#{zipcode}"
end