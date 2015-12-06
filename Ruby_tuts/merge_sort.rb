#!/usr/bin/ruby

def merge_sort(array)
	if array.length < 2
		return array
	else
    half_idx = array.length / 2
		first_half = merge_sort(array[0..half_idx - 1])
		second_half = merge_sort(array[half_idx..array.length - 1])

		sorted_array = merge(first_half, second_half) 

		return sorted_array
	end
end

def merge(first_half, second_half)
	merged_array = Array.new(first_half.length + second_half.length)

	i = 0
	j = 0

  (0..(merged_array.length - 1)).each do |idx|
    if i == first_half.length
      merged_array[idx] = second_half[j]
      j +=1

    elsif j == second_half.length
      merged_array[idx] = first_half[i]
      i +=1

    elsif first_half[i] < second_half[j]
      merged_array[idx] = first_half[i]
      i+=1

    else
      merged_array[idx] = second_half[j]
      j+=1
    end
  end

	return merged_array
end

input_array = [1, 33, 23, 12, 2, 3, 56, 11, 18, 102]
puts "Input: #{input_array}"

output_array = merge_sort(input_array)
puts "Sorted: #{output_array}"

