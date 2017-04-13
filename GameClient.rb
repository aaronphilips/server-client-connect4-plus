require 'socket'

class GameClient

	def run
		s = TCPSocket.open("localhost",50500)
		arr = Array.new
		while ip = s.gets do
			arr.push(ip)
		end
		
		# calvin chooses
		
		s.puts 
		s.close
	end


end

gm = GameClient.new
gm.run