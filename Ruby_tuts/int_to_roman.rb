class IntegerToRoman

  attr_accessor :roman

  NUMERAL_MAP = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  def initialize
    @roman = ""
  end

  def convertIntToRoman(input)
    if input == 0
      return @roman
    else
      NUMERAL_MAP.keys.each do |k|
        quotient = input / k
        modulo = input % k
        @roman << NUMERAL_MAP[k] * quotient 
        return convertIntToRoman(modulo) if quotient > 0
      end 
    end
  end

  def checkInput(input)
    begin 
      num = Integer(input)
    rescue ArgumentError
      puts "Input not an integer!"
      return 0
    end
    return num
  end
end

converter = IntegerToRoman.new

num = converter.checkInput(ARGV[0])
roman = converter.convertIntToRoman(num)

puts "#{num} --> #{roman}"
