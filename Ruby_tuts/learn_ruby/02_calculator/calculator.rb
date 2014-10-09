def add(num1, num2)
	return num1 + num2
end

def subtract(num1, num2)
	return num1 - num2
end

def sum(array)
	sum = 0
	array.each do |i|
		sum += i
	end

	return sum
end


def multiply(num1 = 1, num2 = 1, num3 = 1, num4 = 1)
	return num1 * num2 *num3 * num4
end

def power(num, exp)

	temp = num
   	(exp - 1).times do
   		temp *= num
   	end

   	return temp
end

def factorial(num)
    
    return 1 if num == 0
    
	fact = num
	while(num > 1)
		fact *= (num - 1)
		num -= 1
	end

	return fact
end


def divide(num1, num2)
	return num1/ (num2 * 1.0)
end