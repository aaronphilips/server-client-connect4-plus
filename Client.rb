require 'sqlite3'
require_relative 'DatabaseManager'

class Client

	def initialize
		@dm = DatabaseManager.new
	end


	def get_server_manager_info
		begin 
			@db = SQLite3::Database.open "test.db"
			# @db.transaction
			@res = @db.query('select * from server')
			@res.each_hash{|h| puts h['id']}
			return @res
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		end
	end

	def close_statement
		@res.close
	end

	def set_user(user)
		@user = user
	end


	def check_user_exists
		u = @dm.get_user(@user)
		if u
			@user  = u
		end

	end

	def close_db
		@db.close if @db
	end

	def add_user

		@dm.add_user(@user)
	end



end