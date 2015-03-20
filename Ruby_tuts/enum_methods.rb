module Enumerable

  def my_each

    i = 0
    while i < self.size
      yield self[i]
      i += 1
    end
    self

  end

  def my_each_with_index

    i = 0
    while i < self.size
      yield self[i], i
      i += 1
    end
    self

  end

  def my_select
    selection = []
    self.my_each do |num|
      if(yield(num))
        selection << num
      end
    end
    return selection
  end

  def my_all?
    self.my_each do |num|
      if(!yield(num))
        return false
      end
    end
    return true
  end

  def my_any?

    if block_given?
      self.my_each do |num|
        if(yield(num))
          return true
        end
      end
    else
      self.my_each do |num|
        if(num)
          return true
        end
      end
    end

    return false
  end

  def my_none?

    found = false
    
    if block_given?
      self.my_each do |num|
        if(yield(num))
          found = true
          break
        end
      end
    else
      self.my_each do |num|
        if num
          found = true
          break
        end
      end
    end
    return !found
  end

  def my_count

    count = 0;
    if block_given?
      self.my_each do |num|
        if(yield(num))
          count += 1
        end
      end
    else
      self.my_each do |num|
        count += 1
      end
    end
    return count

  end

  def my_map(proc = nil)
    if block_given? && !proc.nil?
      self.my_each_with_index do |num, i|
        self[i] = yield(num) if yield(num)
      end
    end
    
    if proc.nil?
      return self.to_enum
    end
    proc.call
    self
  end

  def my_inject(result = nil)
    
    if result.nil?
      array = self[1..-1]
      result = self[0]
    end

    if block_given?
      array.my_each do |num|
        result = yield(result, num)
      end
    end
    result
  end

end

def multiply_els(array)

  array.inject do |product, n|
    product * n
  end
end

array = [1, 2, 4, 2]

summe = array.map

summe2 = array.my_map do |i|
  i * i
end

puts "Mult: #{summe}"
puts "Mult: #{summe2}"

