require 'socket'
require 'json'


class SimpleServer

  attr_accessor :client, :server, :http_status

  def initialize(host, port)
    @server = TCPServer.new(host, port)
    puts "Server initialized."
    puts "Host: #{host}\tPort: #{port}"
    open_socket
  end

  # Listen for clients who want to connect.
  def listen_for_client
      puts "Listening..."
      @client = @server.accept
      puts "A client connected."
      @client.puts "Connected to server!"
  end

  # Decide how to handle request.
  def process_client_request(request)
    # process request string
    resp = []
    tokens = request.split(" ")
    target = tokens [1]

    if request =~ /GET\s.+\sHTTP\/1\.[0|1]/
      resp = retrieve_file(target)

    elsif request =~ /POST\s.+\sHTTP\/1\.[0|1]/
      resp = parse_received_data(target)

    else
      @client.puts "Received invalid request."
      resp = ["N/A"]
    end

    return resp
  end

  # Get contents of a requested file.
  def retrieve_file(target)
      # only local dir in tutorial!
      full_path = File.join(File.dirname(__FILE__), target)
      @client.puts "Looking for #{full_path} ..."

      content = []

      # Check if file exists, return appropriate response
      if File.exists?(full_path)
        @http_status = "HTTP/1.1 200 OK"

        # Open the file, read content.
        begin
          File.open(full_path, "r") do |f|
            
            f.each_line do |l|
              content << l
            end
          end
        rescue 
          @client.puts "Error when opening file."
          @http_status = "HTTP/1.0 404 Not Found"
        end

      else
        @http_status = "HTTP/1.0 404 Not Found"
      end

      return content.join("")
  end

  def parse_received_data(data)
      params = JSON.parse(data)
      @client.puts "Received: #{params}"
      resp = get_thanks(params)
      return resp
  end

  def get_thanks(params)
    @http_status = "HTTP/1.1 200 OK"

    viking = params["viking"]
    puts "Params: #{params}"
    puts "Viking: #{viking}"
    puts "Viking Name: #{viking['name']}"

    content = []

    # Open the file, read content.
    begin
      File.open("./thanks.html", "r") do |f|
        
        f.each_line do |l|
          
          if l =~ /^\s*<%= yield %>\s*$/
            content << "<li>Name: #{viking['name']}</li>"
            content << "<li>Email: #{viking['email']}</li>"
          else
            content << l
          end

        end
      end
    rescue 
      @client.puts "Error when opening file."
      @http_status = "HTTP/1.0 404 Not Found"
    end

    return content
  end

  # From determined HTTP status and given response, generate a header.
  def generate_headers(response)

    return [@http_status, 
                  "date: #{Time.now.ctime}", 
                  "server: test",
                  "content-type: text/html; charset=iso-8859-1",
                  "content-length: #{response.length}\r\n\r\n"].join("\r\n")
  end

  # Open a socket on this server and listen to connecting clients.
  def open_socket
    loop {
      listen_for_client

      # read first input line only
      request = @client.gets

      resp = process_client_request(request)
      headers = generate_headers(resp)

      @client.puts headers
      @client.puts resp

      @client.puts "Disconnecting client..."
      @client.close                               # close connection to client
    }
  end
end

SimpleServer.new('localhost', 2000)