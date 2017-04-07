

class Player

	@score
	@username



	def initialize(*args)
		if args.length == 3
			normal_player(args[0],args[1],args[2])
		else
			ai_player(args[0])
		end
	end


	def normal_player(id, username, win_pattern)
		@id = id
		@username = username
		@win_pattern = win_pattern

	end

	def ai_player(win_pattern)
		@id = 2
		@username="AI"
		@win_pattern = win_pattern
	end

	def add_score(point)
		@score = @score + point
	end

	def get_id
		return @id
	end

	def get_username
		return @username
	end


	def get_win_pattern
		return @win_pattern
	end
end
