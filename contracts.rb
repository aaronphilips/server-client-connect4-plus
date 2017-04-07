
def invariant_Board(board_array, rows, columns)
	assert(@board_array.inject(0){|sum,x| sum + x.size } == 42, 'wrong board dimensions') 
	assert(rows == 6, 'rows should be 6')
	assert(columns == 7, 'columns should be 7')
end

def pre_add_piece(player_id, button_id, board_array, rows, columns)
	assert_respond_to(player_id, :round, 'invalid player_id')
	assert_respond_to(button_id, :round, 'invalid button_id')
	assert(button_id >= 0, 'giving a negative button id')
	column_number = button_id%7
	column = board_array.transpose[column_number]
	assert((column.include? 0), 'column too full')
	invariant_Board(board_array, rows, columns)
end

def post_add_piece(board_array, rows, columns)
	assert(yield, 'failed in adding piece properly')
	invariant_Board(board_array, rows, columns)
end

def pre_clear(board_array, rows, columns)
	assert((defined? board_array) != nil, 'no board array was created')
	invariant_Board(board_array, rows, columns)
end

def post_clear(board_array, rows, columns)
	assert(board_array.all? {|row| row.all? {|column| column == 0}}, 'board failed to clear')
	invariant_Board(board_array, rows, columns)
end

def pre_check_for_winner(player, board_array, rows, columns)
	assert_respond_to(player, :get_win_pattern, 'invalid player passed')
	invariant_Board(board_array, rows, columns)
end

def post_check_for_winner(board_array, rows, columns)
	invariant_Board(board_array, rows, columns)
end

def pre_score(win_pattern)
	assert(win_pattern.size == 4, 'invalid win win_pattern')
end 

def post_score(board_array, rows, columns)
	invariant_Board(board_array, rows, columns)
end

def invariant_Manager( board_model, player_list, last_player_id, ai, game_state)
	assert_respond_to(board_model, :add_piece, 'invalid board model')
	assert_respond_to(player_list, :at, 'invalid player_list')
	assert(last_player_id >= 0, 'negative last player id')
	assert((defined? game_state) != nil, 'game state not defined' )
end

def pre_turn(button_id, board_model, player_list, last_player_id, ai, game_state)
	assert(button_id >= 0, 'negative button id')
	invariant_Manager(board_model, player_list, last_player_id, ai, game_state)
end

def post_turn(board_model, player_list, last_player_id, ai, game_state)
	invariant_Manager(board_model, player_list, last_player_id, ai, game_state)
end

def pre_AI_play(board_model, player_list, last_player_id, ai, game_state)
	invariant_Manager(board_model, player_list, last_player_id, ai, game_state)
end

def post_AI_play(board_model, player_list, last_player_id, ai, game_state)
	invariant_Manager(board_model, player_list, last_player_id, ai, game_state)
end

def pre_check_winner(board_model, player_list, last_player_id, ai, game_state)
	invariant_Manager(board_model, player_list, last_player_id, ai, game_state)
end

def post_check_winner(board_model, player_list, last_player_id, ai, game_state)
	invariant_Manager(board_model, player_list, last_player_id, ai, game_state)
end

