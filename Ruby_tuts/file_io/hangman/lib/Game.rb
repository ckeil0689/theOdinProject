# require 'yaml'
require './lib/GameFile'
require './lib/HangmanView'
require './lib/SecretWord'

class Game

  attr_reader :countdown, :secret_word, :turns

  def initialize
    @secret_word = SecretWord.new
    @countdown = 0
    @turns = 0
  end

  def run
    show_options
    choice = "0"

    until is_valid_choice?(choice)
      print "\nEnter your choice (1-3): "
      choice = gets.chomp
      puts
    end

    choice = Integer(choice)
    choose_option(choice)
  end

  # >>>>>>>>> PROTECTED <<<<<<<<<<<<<<<<<<<<<<<
  protected 

  def play
    until @secret_word.is_revealed? || has_lost?
      puts "\n>>>> Turn #{turns}"
      HangmanView.draw_hangman(@countdown)
      @secret_word.display_word
      puts
      puts "Enter 'save' to save game, 'quit' to end the game."
      print "Enter a character to guess the word: "
      guess = gets.chomp

      is_save_or_exit?(guess)
      break if @secret_word.matches?(guess)
      next if !is_valid_char?(guess)

      @countdown += @secret_word.eval_input(guess)
      @turns += 1
    end
    conclude
  end

  # >>>>>>>>> PRIVATE <<<<<<<<<<<<<<<<<<<<<<<
  private

  def choose_option(choice)
    case choice
    when 1
      play
    when 2
      game = GameFile.load_saved_game
      game.play
    else
      end_game
    end
  end

  def is_save_or_exit?(guess)
    if guess.match(/save/)
      GameFile.save_game
    elsif guess.match(/quit/)
      end_game
    end
  end

  def show_options
    puts "What would you like to do?"
    puts
    puts "1. Start New Game"
    puts "2. Load Saved Game"
    puts "3. Exit"
  end

  def is_valid_char?(guess)
    guess.downcase!
    if guess.ascii_only? && guess.match(/[a-z]/)
      return true
    end
    puts "Please enter only English letters [A-z]"
    return false
  end

  def is_valid_choice?(choice)
    choice.downcase!
    if choice.ascii_only? && choice.match(/[1-3]/)
      return true
    end
    return false
  end

  def has_lost?
    return @countdown == HangmanView::ALLOWED_GUESS_NUM
  end

  def conclude
    finished = "GAME"
    if @secret_word.is_revealed?
      puts "You guessed the word correctly! Congrats!"
    elsif has_lost?
      finished = "YOU'RE"
      puts "You lost. The word was #{@secret_word.word}."
      puts "Maybe next time!"
    end
    puts "\n>>>>>>> #{finished} FINISHED <<<<<<<<<"
    HangmanView.draw_hangman(@countdown)
    end_game
  end

  def end_game
    exit(0)
  end
end