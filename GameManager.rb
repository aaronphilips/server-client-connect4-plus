
require_relative 'BoardModel'
require_relative 'BoardController'
require_relative 'Player'
require 'test/unit'
require_relative 'contracts'



class GameManager

	include Test::Unit::Assertions
	@game_type
	@board_model
	@player_list
	@current_player_id
	@ai
	@game_state
	@last_player_id = 0

	def initialize()
		@current_player_id=1
		@game_state = true
	end

	def set_ai(ai)
		@ai = ai
	end

	def set_game_type(game_type)
		@game_type = game_type
	end

	def set_board_model(board_model)
		@board_model = board_model
	end

	def set_player_list(player_list)
		@player_list = player_list.get_list
	end


	def clear_board
		@board_model.clear
	end


	def get_board_array
		@board_model.get_array
	end

	def get_board_model
		return @board_model
	end

	def get_last_player_id
		@current_player_id
	end

	def get_game_state
		@game_state
	end

	def set_game_state(state)
		@game_state = state
	end


	def turn(button_id)
		# p @player_list.class
		# p @current_player_id
		# p @player_list[@current_player_id-1]
		# p @player_list.length
		# p "turn"
		# p @player_list[@current_player_id-1].get_id
		p @last_player_id
		p @current_player_id
		# if (@last_player_id != @current_player_id)
			pre_turn(button_id,@board_model, @player_list, @current_player_id, @ai, @game_state)
			player_id=@player_list[@current_player_id-1].get_id
			# p @board_model.get_array
			if @board_model.add_piece(player_id,button_id)
				# p "GETTING HERE"
				@current_player_id= (@current_player_id==1)? 2:1
			else 

				# @current_player_id= (@current_player_id==1)? 2:1
				return false
			end
			# p "turn"
			# p @player_list[@current_player_id-1].get_id
			post_turn(@board_model, @player_list, @current_player_id, @ai, @game_state)
		# end
		return true
	end

	def AI_play()

		pre_AI_play(@board_model, @player_list, @current_player_id, @ai, @game_state)
		enemy_index = (@current_player_id==1)? 2:1
		enemy_player = @player_list[enemy_index-1]
		position=@ai.get_position(@board_model.get_array,@player_list[@current_player_id-1],enemy_player)
		# p "position"
		# p position
		button_id = position[0]*7+position[1]
		# p button_id
		# sleep 1
		# p "RIGHT BEFORE"
		if @game_state
			turn(button_id)
		end
		post_AI_play(@board_model, @player_list, @current_player_id, @ai, @game_state)



	end




	def check_winner()

		pre_check_winner(@board_model, @player_list, @current_player_id, @ai, @game_state)
		if @board_model.check_for_winner(@player_list[@current_player_id-1])
			return @current_player_id
		end
		post_check_winner(@board_model, @player_list, @current_player_id, @ai, @game_state)
		return false
	end


end
