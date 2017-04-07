require "xmlrpc/server"

port = 50500

class Server
   INTERFACE = XMLRPC::interface("server") {
   meth 'int add(int, int)', 'Add two numbers', 'add'
   meth 'int div(int, int)', 'Divide two numbers'
}
   def add(a, b) a + b end
   def div(a, b) a / b end
end

server = XMLRPC::Server.new(port, ENV['HOSTNAME'])

server.add_handler(Num::INTERFACE,  Num.new)

server.serve