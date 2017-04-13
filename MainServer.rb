require "xmlrpc/server"
require_relative "CalvinsServer"
require "socket"
server = TCPServer.open(2626)
Queue.new.
loop do
	Thread.fork(server.accept) do |client| 


		client.puts("Hello, I'm Ruby TCP server", "I'm disconnecting, bye :*")
		client.funny_function
		client.close
	end
end


# ms=MainServer.new