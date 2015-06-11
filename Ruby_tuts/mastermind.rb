#!/usr/bin/ruby

#Mastermind game
#The Odin Project
#2015

class Game

  MAX_TURNS = 12

  attr_reader :human, :ai
  attr_accessor :code, :maker, :breaker

  def initialize
    set_players
    prep_game
  end

  def run
    turns = 1
    until turns == MAX_TURNS
      puts "TURN #{turns}"

      @breaker.guess

      break if has_won
      @maker.give_hint(@breaker.code_seq)
      @breaker.reset_guess
      turns += 1
    end

    if has_won
      puts "Great, the correct sequence was found: #{@maker.code_seq}"
      exit 0
    else
      puts "Too bad, next time!"
      puts "The code was #{maker.code_seq}"
    end
  end

  private #----------

  def set_players
    players_defined  = false

    until players_defined
      puts "Would you like to create the code? (y/n)"
      answer = gets.chomp.downcase

      if answer == "y"
        puts "You will be the code maker."
        @maker = Maker.new(Player::HUMAN)
        @breaker = Breaker.new(Player::AI)
        players_defined = true
      elsif answer == "n"
        puts "You will be the code breaker."
        @breaker = Breaker.new(Player::HUMAN)
        @maker = Maker.new(Player::AI)
        players_defined = true
      else
        puts "Please only enter 'y' or 'n'."
      end
    end
  end

  def prep_game
    maker.make_code
  end

  def has_won
    return @breaker.guess_code.guess_matches?(@maker.code_seq)
  end
end

class Player

  HUMAN = 1
  AI = 2

  attr_accessor :id

  def initialize(id)
    @id = id
  end  

end

class Maker < Player

  # pins
  NONE = 0
  BLACK = 1
  WHITE = 2

  attr_reader :code_seq

  def initialize(id)
    super(id)
  end

  def make_code
    @gen_code = Code.new
    if @id == Player::HUMAN
      @gen_code.make_seq

      puts "Maker code is:" 
      @gen_code.print(@gen_code.sequence)
    elsif @id == Player::AI
      @gen_code.generate_sequence
    else
      puts "When trying to make a code, the supplied ID is unknown."
    end

    @code_seq = @gen_code.sequence
  end

  def give_hint(guess_code)

    pins = Array.new(NONE)

    black_pins = 0
    white_pins = 0

    # count black (position + color correct)
    guess_code.each_with_index do |guess, i|
      if guess == @code_seq[i]
        black_pins += 1 
        pins[i] = BLACK
      end
    end

    #count whites (color correct only)
    guess_code.each_with_index do |guess, i|
      @code_seq.each_with_index do |color, j|

        if color == guess && pins[j] != BLACK
          white_pins += 1
          pins[j] = WHITE
          break
        end
        
      end
    end

    puts
    puts ">>>> HINT <<<<"
    puts "Black pins (correct color & position): #{black_pins}"
    puts "White pins (correct color): #{white_pins}"
    puts

    if black_pins + white_pins > 4
      puts "Something went wrong with the pins..."
      exit 1
    end
  end
end

class Breaker < Player

  attr_accessor :code_seq, :guess_code

  def initialize(id)
    super(id)
    @guess_code = Code.new
  end

  #generates a guess code 
  def guess
    puts "Write down a guess."
    @guess_code.make_seq
    @code_seq = guess_code.sequence
  end

  def reset_guess
    @guess_code.set_new_seq
  end

end

class Code

  SIZE = 4
  MAX_ID = 6

  attr_accessor :sequence

  def initialize
    set_new_seq
  end

  def make_seq
    puts "Pick #{Code::SIZE} colors. Duplicates are allowed:"
    puts "Red, Green, Blue, Yellow, Orange, Purple"

    until @sequence.length == SIZE
      puts "Add all colors by name (#{SIZE - @sequence.length}):"
      colors = gets.chomp.split(" ")
      add_colors(colors)
    end
  end

  def guess_matches?(guessed_code)
    len = guessed_code.length
    return false if len != SIZE || len != @sequence.length

    @sequence.each_with_index do |col, i|
      return false if col != guessed_code[i]
    end
    return true
  end

  def set_new_seq
    @sequence = Array.new
  end

  def print(code)
    guess_str = ""

    code.each do |col|
      guess_str += get_color_name(col) + " "
    end
    puts "#{guess_str}"
  end

  def generate_sequence

    until @sequence.length == SIZE
      @sequence << 1 + Random.rand(MAX_ID)
    end

    if is_valid(@sequence)
      puts "Code successfully generated."
    else 
      puts "Something went wrong when generating the code."
    end
  end

  def is_valid(code)
    return false if !code.is_a? Array
    return false if code.length != SIZE

    code.each do |col|
      return false if col < 1 || col > MAX_ID
    end

    return true
  end

  private #------------

  def add_colors(colors)

    colors.each do|col|
      id = get_color_id(col)
      @sequence << id if id != 0
    end
  end

  # use an enum?!

  def get_color_name(id)
    return "NONE" if !id.is_a? Integer

    case id
    when 1
      return "RED"
    when 2
      return "GREEN"
    when 3
      return "BLUE"
    when 4
      return "YELLOW"
    when 5 
      return "ORANGE"
    when 6 
      return "PURPLE"
    else
      return "NO_COLOR"
    end
  end

  def get_color_id(color)

    return 0 if !color.is_a? String

    case color.upcase
    when  "RED"
      return 1
    when "GREEN"
      return 2
    when "BLUE"
      return 3
    when "YELLOW"
      return 4
    when "ORANGE"
      return 5
    when "PURPLE"
      return 6
    else
      return 0
    end
  end
end

begin
  puts "Welcome to Mastermind!"
  game = Game.new
  game.run
rescue SystemExit, Interrupt
  puts
  puts "Ok, goodbye :("
end