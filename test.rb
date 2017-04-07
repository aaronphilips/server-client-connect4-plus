
require_relative 'Player'

def compute_horizontal_score(board_array,player,direction)
	player_id = player.get_id

	player_pattern = player.get_win_pattern

	score_hash = Hash.new
	board_array.each_with_index do |row , row_index|
		score_counter = 0
		found_piece = false
		row=(direction)? row : row.reverse
		row.each_with_index do |column, column_index|
			c_index=(direction)? column_index : 6 - column_index

			if player_pattern[score_counter] == board_array[row_index][c_index]
				score_counter=score_counter+1
				found_piece = true
			elsif board_array[row_index][column_index] != 0
				found_piece = false
				score_counter=0
			end

			if board_array[row_index][c_index] == 0 && found_piece
				# p board_array[row_index][c_index]
				if score_counter == 0
					score_counter=1
				end
				score = score_counter*10
				score_hash[[row_index,c_index]]=[player_id,score]
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
				if score_counter == 0
					score_counter=1
				end
				score = score_counter*10
				score_hash[[row_index,column_index]]=[player_id,score]
				found_piece = false
			end
		end
	end
	return score_hash
end


def compute_right_diagonal_up_score(board_array,player)
	player_pattern = player.get_win_pattern
	player_id = player.get_id
	score_hash = Hash.new

	for row_index in 0..board_array.length-1
		for column_index in 0..board_array[0].length-1
			temp_row_index=row_index
			temp_column_index=column_index
			score_counter = 0
			found_piece = false

			while (!(temp_column_index >= board_array[0].length || temp_row_index >= board_array.length))
				board_value=board_array[temp_row_index][temp_column_index]

				if player_pattern[score_counter]==board_value
					score_counter=score_counter+1
					found_piece = true
				elsif board_array[temp_row_index][temp_column_index] != 0
					found_piece = false
					score_counter=0
				end

				if board_array[temp_row_index][temp_column_index] == 0 && found_piece
					if score_counter == 0
						score_counter=1
					end
					score = score_counter*10
					if !score_hash.key?([temp_row_index,temp_column_index])
						score_hash[[temp_row_index,temp_column_index]]=[player_id,score]
					end
					# found_piece = false
					break
				end
				temp_row_index=temp_row_index+1
				temp_column_index=temp_column_index+1
			end
		end
	end
	return score_hash
end

def compute_diagonal_up_score(board_array,player,direction)
	player_pattern = player.get_win_pattern
	player_id = player.get_id
	score_hash = Hash.new

	for row_index in 0..board_array.length-1
		column_array=(direction)? [*(0..board_array[0].length-1)] : [*(0..board_array[0].length-1)].reverse
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
					if score_counter == 0
						score_counter=1
					end
					score = score_counter*10
					if !score_hash.key?([temp_row_index,temp_column_index])
						score_hash[[temp_row_index,temp_column_index]]=[player_id,score]
					end
					# found_piece = false
					break
				end
				temp_row_index=temp_row_index+1
				if direction
					temp_column_index=temp_column_index+1
				else
					temp_column_index=temp_column_index-1
				end
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
					if score_counter == 0
						score_counter=1
					end
					score = score_counter*10
					if !score_hash.key?([temp_row_index,temp_column_index]) 	|| score_hash[[temp_row_index,temp_column_index]][1]<score
						score_hash[[temp_row_index,temp_column_index]]=[player_id,score]
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

board_array = Array.new(6){Array.new(7,0)}
player1 = Player.new(1,"J",[1,1,1,1])

board_array[0][0] = 1
board_array[0][1] = 1
board_array[1][0] = 2
board_array[1][1] = 2
board_array[2][0] = 1
board_array[2][1] = 1
board_array[0][6] = 1
board_array[0][2] = 2
board_array[1][2] = 1



puts format_board(board_array)
puts
# p compute_vertical_score(board_array,player1)
# p compute_horizontal_score(board_array,player1,true)
# p compute_diagonal_score(board_array,player1,false,false)
