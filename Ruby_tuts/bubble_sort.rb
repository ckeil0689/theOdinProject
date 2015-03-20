#!/usr/bin/ruby

def bubble_sort(num_array)
	
  #true to enter first while loop
  swapped = true

  while(swapped)

    swapped = false

    num_array.each_with_index do |num, i|

      break if i == num_array.length - 1

      # swap elements if left is bigger than right
      if(num_array[i] > num_array[i + 1])
        temp = num_array[i]
        num_array[i] = num_array[i + 1]
        num_array[i + 1] = temp
        swapped = true
      end 
    end
  end
end


def bubble_sort_by(array)

  swapped = false
  while(!swapped)

    swapped = false

    array.each_with_index do |num, i|
      
      break if i == array.length - 1

      if yield(num, array[i + 1]) > 0
        temp = array[i]
        array[i] = array[i + 1]
        array[i + 1] = temp
        swapped = true
      end
    end

  end
end


array = [9, 3, 4 , 2, 1 , 5, 7, 2, 8]

puts "Unsorted: #{array}"

bubble_sort(array)

puts "Sorted: #{array}"

array = ["hello", "hi", "hooray"]

puts = "Word-unsorted: #{array}"

bubble_sort_by(array) do |left, right|

  right.length - left.length
end

puts "Word-sorted: #{array}"