require "xmlrpc/server"
require_relative 'DatabaseManager'
require 'sqlite3'
require_relative 'User'


@dm = DatabaseManager.new
@dm.set_up
@db = SQLite3::Database.open "test.db"

port = 50500

class Server
   INTERFACE = XMLRPC::interface("server") {
   meth 'void add_user(string, string, string, int)', 'add user'
   meth 'void get_servers(void)', 'gets current servers', 'get_servers'
   meth 'boolean check_user_exists(User)', 'check if user exists'
}
   def add(a, b) a + b end
   def div(a, b) a / b end
   def add_user(ip, username, password, online)
   	begin
   		@dm = DatabaseManager.new
   	   	puts @dm.class
   		@dm.add_user(ip, username, password, online)
   	rescue Exception => e
   		puts "Exception occurred"
		puts e
   	end

	end

	def get_servers
		begin
			if !@dm
				@dm = DatabaseManager.new
			end
			puts @dm.class
			all_servers = @dm.get_servers
			all_servers.each do |row|
                puts row.join "\s"
            end 
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		end  
	end
end

server = XMLRPC::Server.new(port, ENV['HOSTNAME'])

server.add_handler(Server::INTERFACE,  Server.new)

server.serve