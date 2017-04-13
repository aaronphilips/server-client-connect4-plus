require_relative 'DatabaseManager'

require "socket"

class MainServer

	def initialize

		@dm = DatabaseManager.new
		@dm.set_up
		@dm.add_server(4,1,3)
		@dm.add_server(3,1,3)
		@server = TCPServer.open(50500)

	end

	def run
		loop do
			Thread.fork(@server.accept) do |client|
				username = client.gets
				password = client.gets
				str=@dm.get_user(username,password)
				client.puts str
				signupMessage = client.gets
				if signupMessage=="signup"
					ip = client.gets
					@dm.add_user(ip,username,password)
				end

				available_ips=@dm.get_connected_ips
				puts available_ips
				client.puts available_ips
				# clientMessage=client.gets 
				# if clientMessage=="New"
				# client.puts("Hello, I'm Ruby TCP server", "I'm disconnecting, bye :*")
				# client.funny_function
				client.close
			end
		end

	end



end
ms=MainServer.new
ms.run