class FibonacciCalculator

  attr_reader :bound

  def initialize(input)
    @bound = checkInput(input)
  end

  def fibs
    iterative

    puts "RECURSIVE --------"

    0.upto(@bound - 1) do |x|
      printf "%d\s", recursive(x)
    end
    puts
  end

  private 

  def iterative
    fib1 = 0
    fib2 = 1
    printf "%d\s%d\s", fib1, fib2

    2.upto(@bound - 1) do |x|
      fib = fib1 + fib2
      printf "%d\s", fib
      fib1 = fib2
      fib2 = fib
    end
    puts
  end

  def recursive(n)
    if n == 0 || n == 1
      return n
    else
      return recursive(n - 1) + recursive(n - 2)
    end
  end

  def checkInput(input)
    begin 
      num = Integer(ARGV[0])
    rescue ArgumentError
      puts "Input not a number!"
      return 0
    end
    return num
  end
end

calc = FibonacciCalculator.new(ARGV[0])
calc.fibs