class SecretWord
  
  attr_reader :word, :chars
  attr_accessor :revealed_chars

  def initialize
    @word = get_rand_word
    @chars = @word.split("")
    @revealed_chars = Array.new(@word.length) {|i| i = '_'}
  end

  def display_word
    print "Word:\s"
    @revealed_chars.each do |char|
      print char
    end
    puts
  end

  def matches?(guess)
    if @word.eql? guess
      @revealed_chars = guess.split("")
      puts "Wow you found the word!"
      return true
    end
    return false
  end

  def eval_input(guess)
    correct = 0

    @chars.each_with_index do |c, idx|
      if c == guess
        @revealed_chars[idx] = c
        correct += 1
      end
    end
    if correct == 0
      puts "NOPE!"
      return 1
    else
      puts "Correct!"
      return 0
    end
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
    dir = File.join(Dir.pwd, 'res/5desk.txt')
    file = File.open(dir, 'r')
    lines = file.readlines

    n = lines.length
    rand_idx = Random.rand(n) + 1

    word = lines[rand_idx].chomp.downcase

    return word
  end
end