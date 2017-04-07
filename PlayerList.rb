

class PlayerList

	def initialize(player_object1,player_object2)
		@player_array = Array.new
		@player_array.push(player_object1)
		@player_array.push(player_object2)
	end


	def get_player(player_id)
		@player_array.each do |player|
			if player.get_id == player_id
				return player
			end
		end
	end

	def get_list
		return @player_array
	end

	
	
end