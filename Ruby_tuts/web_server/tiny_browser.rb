require 'socket'
require 'json'

class TinyBrowser

  def initialize(host, port)
    puts
    puts "Welcome to BananaSMG Browser!"
    puts "Connecting to #{host} at port #{port}."
    @socket = TCPSocket.open(host, port)         # open a socket
    browse
  end

  def close_socket
    puts "Closing connection to server."
    @socket.close
  end

  # Find out which request a user would like to make.
  def get_request_type
    puts "Please tell me what request you want to make (GET or POST)?"
    prompt = "> "
    print prompt

    while input = gets.chomp.upcase

      case input
      when "GET"
        return "GET"
      when "POST"
        return "POST"
      else
        puts "#{input} is not valid. Please use 'GET' or 'POST'."
        print prompt
      end
    end
  end

  def get_file_path
    puts "Please enter a file name from local directory only."
    print "> "
    return gets.chomp
  end

  # the tutorial wants to submit viking details in a nested hash
  def get_viking_details

    vikings = Hash.new
    viking_details = Hash.new

    # no input checking yet
    puts "Please enter a Viking name."
    print "> "
    viking_details[:name] = gets.chomp

    puts "Now enter an email address."
    print "> "
    viking_details[:email] = gets.chomp

    vikings[:viking] = viking_details

    return vikings.to_json
  end

  # Formulate an HTTP request to retrieve the file we want
  def make_request
    request_type = get_request_type

    if request_type.eql? "GET"
      path = get_file_path  # The file to access

    elsif request_type.eql? "POST"
      path = get_viking_details

    else
      puts "Unknown request type: #{request_type}"
      puts "Aborting."
      close_socket
    end
    return "#{request_type} #{path} HTTP/1.0\r\n\r\n"
  end

  # Print the server response.
  def process_response
    # response = socket.read              # read response

    # # Split response at first blank line into headers and body
    # headers, body = response.split("\r\n\r\n", 2)
    # print body
    puts "Server response:"
    puts "------------\n"

    while line = @socket.gets
      puts line
    end
  end

  def send_request(request)
    puts "Sending request: #{request}"
    @socket.print(request)
  end

  # A single browsing session. Ends after one request.
  def browse
    request = make_request 
    send_request(request)
    process_response
    close_socket
  end
end

TinyBrowser.new('localhost', 2000)
