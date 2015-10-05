require 'socket'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

while line = s.gets  	    # read lines from socket
	puts line.chop   	      # output lines
end

s.close					          # close socket when done