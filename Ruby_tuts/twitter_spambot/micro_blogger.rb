require 'jumpstart_auth'

class MicroBlogger

  attr_reader :client

  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end

  def run
    puts "Welcome to the OdinProj Twitter Client."
    puts "Use 'q' to quit."

    input = ""
    while input != "q"
      printf "Enter command: "
      input = gets.chomp
      process(input)
    end
  end

  private 

  def process(input)
    parts = input.split(" ")
    command = parts[0]

    case command
    when 'q' then puts "Goodbye!"
    when 't' then tweet(parts[1..-1].join(" "))
    when 'dm' then dm(parts[1], parts[2..-1].join(" "))
    when 'spam' then spam_all_followers(parts[1..-1].join(" "))
    when 'elt' then print_all_last_tweets
    when 'p' then print_followers
    else
      puts "Sorry, the command '#{command}' is undefined."
    end
  end

  def tweet(message)
    @client.update(message)
    puts "Message tweeted."
  end

  def dm(target, message)
    puts "Trying to send #{target} a direct message."
    puts message
    if is_follower?(target)
      message = "d #{target} #{message}"
      tweet(message)
    else
      puts "You cannot send a direct message to #{target}. They are not listed"\
      " in your follower list."
    end
  end

  def get_followers
    return @client.followers.collect{|f| @client.user(f).screen_name}
  end

  def is_follower?(target)
    follower_names = get_followers
    if follower_names.include? target
      return true
    end
    return false
  end

  def spam_all_followers(message)
    followers = get_followers
    followers.each do |f|
      dm_tweet = "dm #{f} #{message}"
      process(dm_tweet)
    end
  end

  def print_followers
    follower_names = get_followers
    follower_names.each do |f| 
      puts f
    end
  end

  def print_all_last_tweets
    if @client.user.friends_count < 1
      puts "You have no Twitter friends."
      return
    end
    friends = @client.friends
    puts "Printing #{@client.user.friends_count} tweets..."
    count = 1
    friends.each do |friend|
      print_tweet(friend, count)
      count+=1
    end
  end

  def print_tweet(friend, count)
      puts "#{count}) -------------------"
      name = @client.user(friend).screen_name
      last_tweet = @client.user(friend).status.text
      timestamp = @client.user(friend).created_at
      time_str = timestamp.strftime("%A, %b %d")
      puts "@#{name} tweeted at #{time_str}:"
      puts "#{last_tweet}"
      puts
  end
end

blogger = MicroBlogger.new
blogger.run