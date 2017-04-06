require_relative 'Client'
require_relative 'User'
require_relative 'DatabaseManager'
dm = DatabaseManager.new
dm.set_up
client = Client.new
res = client.get_server_manager_info

puts res.each_hash{|h| puts h['id']}
user = User.new("jayfeather","localhost","password")
client.set_user(user)
if !client.check_user_exists
	puts "nothign found"
	client.add_user
end
client.close_statement