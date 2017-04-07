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
   meth 'void add_server(int, string)', 'adds new server', 'add_server'
}
   def add(a, b) a + b end
   def div(a, b) a / b end
   def add_server(id, ip)
		# puts user.class
		begin
			@db = SQLite3::Database.open "test.db"
			@db.transaction
			stm=@db.prepare "INSERT INTO server(id,clientID, ip)
			SELECT MAX(id),?,? from server"

			stm.bind_param 1, id
			stm.bind_param 2, ip

			stm.execute
			@db.commit
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		end
	end
end

server = XMLRPC::Server.new(port, ENV['HOSTNAME'])

server.add_handler(Server::INTERFACE,  Server.new)

server.serve