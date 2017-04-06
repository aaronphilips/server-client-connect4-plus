class User

	def initialize(username,ip,password)
		@username = username
		@ip = ip
		@password = password
	end

	def get_username
		return @username
	end

	def get_ip
	 return @ip
	end

	def get_password
		return @password
	end

	def set_username(username)
		@username = username
	end

	def set_ip(ip)
		@ip = ip
	end

	def set_password(password)
		@password = password
	end

	def set_wins(wins)
		@wins = wins
	end

	def set_losses(losses)
		@losses = losses
	end

	def set_league(league)
		@league = league
	end

	def set_id(id)
		@id = id
	end

	def get_wins
		return @wins
	end

	def get_losses
		return @losses
	end

	def get_league
		return @league
	end

	def get_id
		return @id
	end


end