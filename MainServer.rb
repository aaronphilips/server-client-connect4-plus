require "xmlrpc/server"
require_relative "CalvinsServer"
require "socket"
Queue.new

class MainServer

	def initialize

		@dm = DatabaseManager.new
		server = TCPServer.open(2626)

	end

	def run
		@dm.getGameServers
.
		loop do
			Thread.fork(server.accept) do |client| 
				client.puts("Hello, I'm Ruby TCP server", "I'm disconnecting, bye :*")
				client.funny_function
				client.close
			end
		end

	end

end
# ms=MainServer.new