#!/usr/bin/ruby

class Hangman

  # for drawing the hangman
  HANGMAN_SYMBOLS = ['O', '|', '\\', '/', '/', '\\'];
  ALLOWED_GUESS_NUM = HANGMAN_SYMBOLS.length

  def initialize
    
  end

  def draw_hangman(false_guess_num)

    puts "Hangman: #{false_guess_num}"
  end

end

class SecretWord
  
  attr_reader :word, :chars
  attr_accessor :revealed_chars

  def initialize
    @word = get_rand_word
    @chars = @word.split("")
    @revealed_chars = Array.new(@word.length) {|i| i = '_'}
  end

  def display_word
    @revealed_chars.each do |char|
      print char
    end
    puts
  end

  def eval_input(guess)
    correct = 0

    @chars.each_with_index do |c, idx|
      if c == guess
        @revealed_chars[idx] = c
        correct += 1
      end
    end
    return (correct == 0) ? 1 : 0
  end

  def is_revealed?
    revealed_word = @revealed_chars.join
    if revealed_word.eql? @word
      return true
    end
    return false
  end

  private

  def get_rand_word
    file = File.open('5desk.txt', 'r')
    lines = file.readlines

    n = lines.length
    rand_idx = Random.rand(n) + 1

    word = lines[rand_idx].chomp.downcase

    return word
  end
end

class Game

  attr_reader :countdown, :hangman, :secret_word

  def initialize
    @secret_word = SecretWord.new
    @countdown = 0
    @hangman = Hangman.new
  end

  def run
    turns = 0
    until @secret_word.is_revealed? || has_lost?
      puts "Turn #{turns}"
      @secret_word.display_word
      puts
      print "Enter a character to guess the word: "
      guess = gets.chomp

      break if guess.eql? @secret_word.word

      next if !is_valid_char?(guess)
      puts "Valid"

      @countdown += @secret_word.eval_input(guess)

      @hangman.draw_hangman(@countdown)
      turns += 1
    end
    conclude
  end

  private 

  def is_valid_char?(guess)
    guess.downcase!
    if !guess.ascii_only? && !guess.match(/[a-z]/)
      puts "Please enter only English letters [A-z]"
      return false
    end
    return true
  end

  def has_lost?
    return @countdown == Hangman::ALLOWED_GUESS_NUM
  end

  def conclude
    if @secret_word.is_revealed?
      puts "You guessed the word correctly! Congrats!"
    elsif has_lost?
      puts "You lost. The word was #{@secret_word.word}."
      puts "Maybe next time!"
    end
  end
end

puts "Ruby Hangman ----"
game = Game.new
game.run