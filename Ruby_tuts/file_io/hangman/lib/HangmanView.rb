class HangmanView

  # for drawing the hangman
  HANGMAN_HEAD = ["\s\sO"] 
  HANGMAN_BODY = ["\s/", "|", "\\"]
  HANGMAN_LEGS = ["\s/", "\s\\"]

  ALLOWED_GUESS_NUM = 6

  def self.draw_hangman(false_guess_num)

    puts "FALSE: #{false_guess_num} /#{ALLOWED_GUESS_NUM}"

    puts "\t\t========="
    puts "\t\t\s\s:\t\u2503"
    puts "\t\t\s\s:\t\u2503"
    puts "\t\t\s\s:\t\u2503"

    (0..ALLOWED_GUESS_NUM).each do |i|
      
      # count to make up in height later
      body_parts = 0
      puts "i: #{i}"

      # rows with body parts
      if false_guess_num == i - 1
        if false_guess_num > 0
          print "\t\t"
          print HANGMAN_HEAD[0]
          print "\t\u2503\n"
        end
        if false_guess_num > 1
          print "\t\t"
          (0..false_guess_num - 2).each do |j|
            print HANGMAN_BODY[j]
            body_parts += 1
          end
          body_parts -= 1 #compensate for line break
          print "\t\u2503\n"
        end
        if false_guess_num > 4
          print "\t\t"
          (0..false_guess_num - 5).each do |j|
            print HANGMAN_LEGS[j]
            body_parts += 1
          end
          body_parts -= 1 #compensate for line break
          print "\t\u2503\n"
        end
      end

      #rows after the body part (poles only)
      if i > false_guess_num
        print_pole_rows(body_parts)
      end
    end
    puts "\t\t========="
  end

  private 

  def self.print_pole_rows(num)
    (0..num).each do |i|
      print "\t\t\t\u2503\n"
    end
  end
end