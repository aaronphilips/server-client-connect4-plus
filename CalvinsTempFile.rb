require_relative 'Client'
require_relative 'User'
client = Client.new
res = client.get_server_manager_info

puts res.each_hash{|h| puts h['id']}
user = User.new("jayfeather","localhost","password")
client.set_user(user)
client.check_user_exits
client.close_statement