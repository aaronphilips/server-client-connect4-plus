require "xmlrpc/server"
require_relative 'DatabaseManager'
require 'sqlite3'


@dm = DatabaseManager.new
@dm.set_up

port = 50500

class Server
   INTERFACE = XMLRPC::interface("server") {
   meth 'int add(int, int)', 'Add two numbers', 'add'
   meth 'int div(int, int)', 'Divide two numbers'
   meth 'void add_server(fixnum, string, fixnum)', 'adds new server', 'add_server'
   meth 'void get_servers()', 'gets current servers', 'get_servers'
}
   def add(a, b) a + b end
   def div(a, b) a / b end
   def add_server(id, ip, online)
		# puts user.class
		begin
			@db = SQLite3::Database.open "test.db"
			@db.transaction
			stm=@db.prepare "INSERT INTO server(id,clientID, ip, online)
			SELECT IFNULL(MAX(id), 0) + 1,?,?,? from server"

			puts "binding #{id.class}, #{ip.class}, #{online.class}"
			stm.bind_param 1, id
			stm.bind_param 2, ip
			stm.bind_param 3, online
			puts "finsihed binding"
			results = stm.execute
			puts "finsihed execute"
		rescue SQLite3::Exception => e
			puts "oops"
			puts "Exception occurred"
			puts e
		end
	end

	def get_servers
		begin
			@db = SQLite3::Database.open "test.db"
			@db.transaction
			stm=@db.prepare "select clientID, ip from server where online = 1 "

			online_servers = stm.execute
			@db.commit
			return online_servers
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		end	
	end
end

server = XMLRPC::Server.new(port, ENV['HOSTNAME'])

server.add_handler(Server::INTERFACE,  Server.new)

server.serve