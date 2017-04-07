require_relative 'Player'
require_relative 'BoardModel'

class AI

	def initialize(difficulty_level)
		@difficulty_level = difficulty_level
	end


	def possible_moves(board_array)
		hash = Hash.new
		for column_index in 0..board_array[0].length-1
			board_array.each_with_index do |row, row_index|
				if board_array[row_index][column_index] == 0
					hash[[row_index,column_index]]=0
					break
				end
			end

		end
		return hash
	end



	def compute_enemy_scores(board_array,player)
		hash1= compute_horizontal_score(board_array,player,true)
		hash2=compute_horizontal_score(board_array,player,false)
		hash3=compute_vertical_score(board_array,player)
		hash4=compute_diagonal_score(board_array,player,true,true)
		hash5=compute_diagonal_score(board_array,player,true,false)
		hash6=compute_diagonal_score(board_array,player,false,true)
		hash7=compute_diagonal_score(board_array,player,false,false)
		totalHash=Hash.new

		totalHash=totalHash.merge(hash1){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash2){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash3){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash4){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash5){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash6){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash7){|k,v1,v2| v1+v2}
		return totalHash
	end


		def compute_my_scores(board_array,player)
		hash1= compute_horizontal_score(board_array,player,true)
		hash2=compute_horizontal_score(board_array,player,false)
		hash3=compute_vertical_score(board_array,player)
		hash4=compute_diagonal_score(board_array,player,true,true)
		hash5=compute_diagonal_score(board_array,player,true,false)
		hash6=compute_diagonal_score(board_array,player,false,true)
		hash7=compute_diagonal_score(board_array,player,false,false)
		totalHash=possible_moves(board_array)

		totalHash=totalHash.merge(hash1){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash2){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash3){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash4){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash5){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash6){|k,v1,v2| v1+v2}
		totalHash=totalHash.merge(hash7){|k,v1,v2| v1+v2}
		return totalHash
	end

	def get_position(board_array,player,enemy)

		my_hash = compute_my_scores(board_array,player)
		enemy_hash = compute_enemy_scores(board_array,enemy)
		p my_hash
		p enemy_hash

		totalHash= my_hash.merge(enemy_hash){|k,v1,v2| v1+v2}

		p totalHash
		p " "
		best_move_key,best_move_value=totalHash.max_by{|k,v| v}
		totalHash.delete(best_move_key)
		second_move_key,second_move_value=totalHash.max_by{|k,v| v}
		while (second_move_value==best_move_value)
			totalHash.delete(second_move_key)
			second_move_key,second_move_value=totalHash.max_by{|k,v| v}
		end
		# p "best move key"
		# p best_move_key
		# p best_move_value
		# p "second best move key"
		# p second_move_key
		# p second_move_value
		case @difficulty_level

			when 1
				if rand > 0.5
					return best_move_key
				end
				return second_move_value
			when 2
				if rand > 0.2
					return best_move_key
				end
				return second_move_value
			when 3
				return best_move_key
		end
		return best_move_key

	end


	def compute_horizontal_score(board_array,player,direction)
		player_id = player.get_id

		player_pattern = player.get_win_pattern

		score_hash = Hash.new
		board_array.each_with_index do |row , row_index|
			score_counter = 0
			found_piece = false
			# row=(direction)? row : row.reverse
			row.each_with_index do |column, column_index|
				#gets
				c_index=(direction)? column_index : 6 - column_index
				if player_pattern[score_counter] == board_array[row_index][c_index]


					score_counter=score_counter+1
					found_piece = true
				elsif board_array[row_index][c_index] != 0

					found_piece = false
					score_counter=0
				end

				if board_array[row_index][c_index] == 0 && found_piece
					# p board_array[row_index][c_index]
					# if score_counter == 0
					# 	score_counter=1
					# end
					# score = (score_counter+1)*10
					score = 10**(score_counter+1)

					if row_index==0|| board_array[row_index-1][c_index] != 0
						if score_counter == player_pattern.length-1 || player_pattern[score_counter + 1]==player_id
							score_hash[[row_index,c_index]]=score
						end
					end
					found_piece = false
				end
			end
		end
		return score_hash

	end


	def compute_vertical_score(board_array, player)
		player_pattern = player.get_win_pattern
		player_id = player.get_id
		score_hash = Hash.new
		for column_index in 0..board_array[0].length-1
			found_piece = false
			score_counter = 0
			board_array.each_with_index do |row , row_index|

				if player_pattern[score_counter] == board_array[row_index][column_index]
					score_counter=score_counter+1
					found_piece = true
				elsif board_array[row_index][column_index] != 0
					found_piece = false
					score_counter=0
				end

				if board_array[row_index][column_index] == 0 && found_piece
					# p board_array[row_index][c_index]
					# if score_counter == 0
					# 	score_counter=1
					# end
					# score = (score_counter+1)*10
					score = 10**(score_counter+1)

					if row_index==0|| board_array[row_index-1][column_index] != 0
						if score_counter == player_pattern.length-1 || player_pattern[score_counter + 1]==player_id
							score_hash[[row_index,column_index]]=score
						end
					end
					found_piece = false
				end
			end
		end
		return score_hash
	end


	def compute_diagonal_score(board_array,player,direction1,direction2)
		player_pattern = player.get_win_pattern
		player_id = player.get_id
		score_hash = Hash.new

		player_pattern = player.get_win_pattern
		player_id = player.get_id
		score_hash = Hash.new
		row_array = (direction2)? [*0..board_array.length-1] : [*0..board_array.length-1].reverse
		for row_index in 0..board_array.length-1
			column_array=(direction1)? [*(0..board_array[0].length-1)] : [*(0..board_array[0].length-1)].reverse
			for column_index in column_array
				temp_row_index=row_index
				temp_column_index=column_index
				score_counter = 0
				found_piece = false

				while (!(temp_column_index >= board_array[0].length || temp_row_index >= board_array.length||temp_column_index<0||temp_row_index<0))
					board_value=board_array[temp_row_index][temp_column_index]

					if player_pattern[score_counter]==board_value
						score_counter=score_counter+1
						found_piece = true
					elsif board_array[temp_row_index][temp_column_index] != 0
						found_piece = false
						score_counter=0
					end

					if board_array[temp_row_index][temp_column_index] == 0 && found_piece
						# if score_counter == 0
						# 	score_counter=1
						# end
						# score = (score_counter+1)*10
						score = 10**(score_counter+1)

						if !score_hash.key?([temp_row_index,temp_column_index]) 	|| score_hash[[temp_row_index,temp_column_index]]<score
							if temp_row_index==0|| board_array[temp_row_index-1][temp_column_index] != 0
								if score_counter == player_pattern.length-1 || player_pattern[score_counter + 1]==player_id
									score_hash[[temp_row_index,temp_column_index]]=score
								end
							end
						end
						# found_piece = false
						break
					end
					if direction2
						temp_row_index=temp_row_index+1
					else
						temp_row_index=temp_row_index-1
					end
					if direction1
						temp_column_index=temp_column_index+1
					else
						temp_column_index=temp_column_index-1
					end
				end
			end
		end

		return score_hash
	end

	def format_board(board_array)

		return_str = ""
		board_array.reverse.each do |row|
			return_str=return_str+row.to_s+"\n"
		end
		return return_str
	end

end
