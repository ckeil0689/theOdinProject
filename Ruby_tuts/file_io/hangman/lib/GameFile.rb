require 'yaml'

class GameFile

  def self.save_game
    dir = File.join(Dir.pwd, '/saved_games/')
    filename = get_yaml_filename

    File.open(dir + filename, 'w') do |file|
      file.write self.to_yaml
    end
  end

  def self.load_saved_game
    saved_files = list_saved_files
    if saved_files.length < 1
      puts "No saved files. Starting new game."
      play
    else
      puts "Enter 'delete < num >' to delete a file."

      choice = ""
      until entered_num?(choice)
        print "Choose the file you want to load (number): "
        choice = gets.chomp

        number = Integer(choice[/[0-9]+/])

        if choice.match(/^delete [1-9][0-9]*$/) && number > 0
          delete_save_file(saved_files[number - 1])
        end
      end

      if number > 0
        game = load_yaml(saved_files[number - 1])
        return game
      else
        puts "Weird number chosen. Crashing now. \ 
        Smack the programmer in the face."
        end_game
      end
    end
  end

  private

  def self.load_yaml(filename)
    begin
      puts "Loading..."
      game = YAML::load(File.read filename)
    rescue
      puts "Unable to load file #{filename}"
    end
    return game
  end

  def self.entered_num?(choice)
    choice.match(/^[0-9]+$/)
  end

  def self.delete_save_file(filename)
    puts "Deleting..."
    begin
      File.delete(filename)
      puts "#{File.basename(filename)} was deleted!"
    rescue StandardError => e
      puts "Could not delete #{filename}"
      puts "Exception: #{e.class}"
    end
  end

  def self.list_saved_files
    save_dir = get_save_game_dir
    dir = File.join(save_dir, "*.yaml")
    saved_files = Dir.glob(dir)
    saved_files.each_with_index do |file, idx|
      puts "#{idx + 1}. #{File.basename(file)}"
    end
    puts
    return saved_files
  end

  def self.get_yaml_filename
    print "Enter file name: "
    filename = gets.chomp
    if filename.length == 0
      filename = "last_game.yaml"
    else
      filename += ".yaml"
    end
    return filename
  end

  def self.get_save_game_dir
    return File.join(Dir.pwd, '/saved_games/')
  end
end