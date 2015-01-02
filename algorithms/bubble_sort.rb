#!/usr/bin/ruby

################################################
# Ruby implementation of bubble sort algorithm #
################################################

def bubble_sort(array)
  swaps = 1 # initialize with 1 to start the while loop
  while swaps != 0
  	swaps = 0
    (0..array.length - 2).each do |i|
       if array[i] > array[i + 1]
         # swap
         tmp = array[i]
         array[i] = array[i + 1]
         array[i + 1] = tmp
         swaps += 1
       end	
    end
  end
  array
end

array = [4,3,78,2,0,2]
puts "Unsorted: #{array}"

bubble_sort(array)
puts "Sorted: #{array}"

def bubble_sort_by(array)

 swaps = 1 # initialize with 1 to start the while loop
  while swaps != 0
  	swaps = 0
    (0..array.length - 2).each do |i|
       if yield(array[i], array[i + 1]) < 0
         # swap
         tmp = array[i]
         array[i] = array[i + 1]
         array[i + 1] = tmp
         swaps += 1
       end	
    end
  end
  array
end

sorted = bubble_sort_by(["hi","hello","hey"]) do |left,right|
  right.length - left.length
end

puts "Sorted: #{sorted}"