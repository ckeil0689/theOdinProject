#!/usr/bin/ruby

#Mastermind game
#The Odin Project
#2015

class Game

  MAX_TURNS = 12

  attr_reader :human, :ai
  attr_accessor :code

  def initialize
    set_players
    prep_game
  end

  def run
    turns = 0
    until turns == MAX_TURNS
      puts "TURN #{turns}"


      turns += 1
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
        @human = Player.new(Player::MAKER)
        @ai = Player.new(Player::BREAKER)
        players_defined = true
      elsif answer == "n"
        puts "You will be the code breaker."
        @human = Player.new(Player::BREAKER)
        @ai = Player.new(Player::MAKER)
        players_defined = true
      else
        puts "Please only enter 'y' or 'n'."
      end
    end
  end

  def prep_game
    @code = Code.new
    if @human.id == Player::MAKER
      puts "Pick #{Code::SIZE} colors. Duplicates are allowed:"
      puts "Red, Green, Blue, Yellow, Orange, Purple"

      until @code.sequence.length == Code::SIZE
        puts "Add a color (#{Code::SIZE - @code.sequence.length} left):"
        color = gets.chomp
        @code.add_color(color)
        @code.print(@code.sequence)
      end

      puts "Your final code is: #{@code.print(@code.sequence)}"

    elsif @human.id == Player::BREAKER
      puts "AI is generating a code..."
      @code.generate_sequence

      puts "[TEST] final code is: #{@code.print(@code.sequence)}"
    else
      puts "Something blew up inside the code. Sorry :("
      exit 1
    end
  end
end

class Player

  MAKER = 1
  BREAKER = 2

  attr_accessor :id, :role

  def initialize(id)
    @id = id
  end  

end

class AI_Player < Player

  def initialize
    super
  end
end

class Code

  SIZE = 4
  COLORS = (1..SIZE).to_a

  attr_accessor :sequence

  def initialize
    @sequence = Array.new
  end

  def guess_matches?(guessed_code)
    @sequence.each_with_index do |col, i|
      return false if col != guessed_code[i]
    end
    return true
  end

  def print(code)
    guess_str = ""

    code.each do |col|
      guess_str += get_color_name(col) + ", "
    end
    puts "Current code is: #{guess_str}"
  end

  def add_color(color)
    id = get_color_id(color)
    @sequence << id if id != 0
  end

  def generate_sequence

    until @sequence.length == SIZE
      @sequence << 1 + Random.rand(6)
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
      return false if col < 1 || col > SIZE
    end

    return true
  end

  private #------------

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

puts "Welcome to Mastermind!"
game = Game.new