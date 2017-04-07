require_relative 'Client'
require_relative 'User'
require "xmlrpc/client"
require_relative 'DatabaseManager'
require 'socket'
# dm = DatabaseManager.new
# dm.set_up

clientStub = XMLRPC::Client.new(ENV['HOSTNAME'], "/RPC2", 50500)
clientRPC = clientStub.proxy("server")


client = Client.new
res = client.get_server_manager_info

# puts res.each_hash{|h| puts h['id']}

while true
	print "enter username: "
	username = gets.chomp
	print "enter password: "
	password = gets.chomp
	ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
	inputIP = ip.ip_address
	# p inputIP.class
	user = User.new(username,inputIP,password)
	client.set_user(user)
	if !client.check_user_exists
		while true
			puts "incorrect username or password!"
			print "would you like to sign up? y for yes, anything else to try again: "
			answer = gets.chomp
			if (answer == "y")
				puts "new user!"
				client.add_user
				client.check_user_exists
				user = client.get_user
				# p user.get_id, user.get_ip
				clientRPC.add_server(user.get_id, user.get_ip)
				break
			end
			break
		end
	else
		puts "welcome!"

		break
	end
end
# user = User.new("jayfeather","localhost","password")
# client.set_user(user)
# if !client.check_user_exists
# 	puts "nothing found"
# 	client.add_user
# end
client.close_statement

# if ARGV.length == 0
# 	app  = App.new
# else
	print "all servers connected: "

	print "How many players 1 or 2? Please Type: "
	players = STDIN.gets.chomp.to_i
	print "Game mode? Type \"C\" for original, \"T\" for otto and toot"
	game_mode = STDIN.gets.chomp
	board_model = BoardModel.new()
	# board_model.add_observer(self)
	game_manager  = GameManager.new
	if players == 2
		if game_mode == "C"
				player1 = Player.new(1,"jayfeather",[1,1,1,1])
				player2 = Player.new(2,"shade",[2,2,2,2])
		elsif game_mode == "T"
				player1 = Player.new(1,"jayfeather",[1,2,2,1])
				player2 = Player.new(2,"shade",[2,1,1,2])
		end
		playerList = PlayerList.new(player1,player2)
		# p @playerList.get_list

		# end

		game_manager.set_player_list(playerList)
		game_manager.set_board_model(board_model)
		game_manager.set_game_type(game_mode)

	elsif players == 1
        p "difficulty level? 1 , 2 or 3?"
		level = STDIN.gets.chomp
		if game_mode == "C"
				player1=Player.new(1,"jayfeather",[1,1,1,1])
				player2=Player.new([2,2,2,2])
		elsif game_mode == "T"
				player1 = Player.new(1,"shade",[1,2,2,1])
				player2=Player.new([2,1,1,2])
		end


		ai = AI.new(level)
		game_manager.set_ai(ai)
		playerList = PlayerList.new(player1,player2)
	# p @playerList.get_list


		game_manager.set_player_list(playerList)
		game_manager.set_board_model(board_model)
		game_manager.set_game_type(game_mode)

    else
        p "ERRORsss"

	end

	while true
		print "row? (0,6)"
		row = STDIN.gets.chomp.to_i
		print "columns? (0,7)"
		column = STDIN.gets.chomp.to_i
		turn_front_end_two(row,column,players,game_manager)
		puts game_manager.get_board_model
		if game_manager.check_winner
			p "Winner"
			break
		end
	end
# end