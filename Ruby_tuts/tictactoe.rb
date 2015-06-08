#!/usr/bin/ruby

#Tic-tac-toe game
#The Odin Project
#2015

class Grid

  attr_reader :field_set, :filled_fields, :size
  attr_accessor :status

  def initialize
    setup_grid
    @status = "none"
    @filled_fields = 0
  end

  def set_field(id, val)

    if @field_set.has_key?(id) then
      @field_set[id] = val
      @filled_fields += 1
      return true
    end

    puts "This field does not exist. Try again!"
    return false

  end

  def print

    puts
    puts "     1    2    3 "
    print_row("1")
    print_row("2")
    print_row("3")
    puts

  end

  private #--------------------------

  def print_row(row_id)

    row = row_id + "  "

    @field_set.each do |key, value|

      next if key[0] != row_id #messy...
      
      case value
      when Game::FIRST_PLAYER
        row += "| X |"
      when Game::SECOND_PLAYER
        row += "| O |"
      else
        row += "| . |"
      end

    end

    puts "    ---  ---  ---"
    puts row

  end

  def setup_grid

    row_ids = [1, 2, 3]
    col_ids = [1, 2, 3]

    @field_set = Hash.new

    row_ids.each do |r|

      col_ids.each do |c|

        id = r.to_s + c.to_s
        field_set[id] = 0

      end

    end

    @size = @field_set.size

  end
end

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
class Game

  FIRST_PLAYER = 1
  SECOND_PLAYER = 2

  attr_reader :grid
  attr_accessor :player1, :player2, :won

  def initialize(player1, player2)
    make_grid
    @player1 = player1
    @player2 = player2
    @active_player = @player2
    @won = "none"
  end

  def run

    begin
      grid.print

      row_num = -1
      col_num = -1

      while(!has_won(row_num, col_num) && !has_game_finished)

        @active_player = get_new_active(@active_player)

        has_entered = false

        while(!has_entered)
          puts "Player #{@active_player.id}, enter a row:"
          row_num = Integer(gets.chomp) rescue next

          puts "Player #{@active_player.id}, enter a column:"
          col_num = Integer(gets.chomp) rescue next

          field_id = row_num.to_s + col_num.to_s

          if is_field_taken?(field_id) then
            puts "Field has already been chosen."
          else
            has_entered = grid.set_field(field_id, @active_player.id)
          end

          if has_entered then
            @active_player.add_field(field_id)
          end

        end

        grid.print

      end

      conclude

    rescue SystemExit, Interrupt
      puts
      puts "Ok, goodbye :("
    end

  end

  private #---------------------------------

  def make_grid
    @grid = Grid.new
  end

  def get_new_active(last_player)

    return (last_player.id == FIRST_PLAYER) ? @player2 : @player1

  end

  def is_field_taken?(field_id)

    return @player1.has_field?(field_id) || @player2.has_field?(field_id)

  end

  #check if all grid fields have been filled. The game needs to stop at that.
  def has_game_finished

    if @grid.filled_fields == @grid.size then
      puts "All fields filled."
      return true
    end

    return false
  end

  # checks winning conditions
  def has_won(row, col)

    return false if row < 0 || col < 0

    #some indices to work with... could be taken from Array if I wasnt using
    #a hash to represent row/col ids...
    ids = [1, 2, 3]

    #first check if all row values are filled by one player
    ids.each_with_index do |i, index|

      id = row.to_s + i.to_s

      break if @grid.field_set[id] != @active_player.id

      if index == ids.length - 1
        set_won(@active_player.id)
        return true
      end
    end

    # check the column
    ids.each_with_index do |i, index|

      id = i.to_s + col.to_s

      break if @grid.field_set[id] != @active_player.id

      if index == ids.length - 1
        set_won(@active_player.id)
        return true
      end
    end

    # check the diagonal
    ids.each_with_index do |i, index|

      id = i.to_s + i.to_s

      break if @grid.field_set[id] != @active_player.id

      if index == ids.length - 1
        set_won(@active_player.id)
        return true
      end
    end

    # check the anti-diagonal
    ids.each_with_index do |i, index|

      id = (ids[ids.length - index - 1]).to_s + i.to_s

      break if @grid.field_set[id] == 0

      if index == ids.length - 1
        set_won(@active_player.id)
        return true
      end
    end

    return false

  end

  def set_won(player_id)
    @won = (player_id == FIRST_PLAYER) ? "First player" : "Second Player"
  end

  def conclude
    puts "Done. The winner is: #{@won}. Congrats!"
    exit 
  end

end

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
class Player

  @@players = 0

  attr_reader :id
  attr_accessor :field_choices

  def initialize

    @@players += 1

    if @@players > 2
      puts "Can only create 2 players."
      @@players = 2
      return
    end

    @id = @@players
    @field_choices = Array.new

  end

  def add_field(field_id)
    
    field_choices << field_id
  end

  def has_field? (field_id)

    return field_choices.include?(field_id)

  end

end

puts "Hello! Let's play Tic tac Toe."
game = Game.new(Player.new, Player.new)
puts "Starting game..."
game.run
