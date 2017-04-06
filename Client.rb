require 'sqlite3'

class Client

	def initialize

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
		begin
			stm = @db.prepare 'select * from users where username=? and password =?'
			stm.bind_param 1, @user.get_username
			stm.bind_param 2, @user.get_password
			user_info = stm.execute

			puts user_info.eof?
			if user_info.next != nil
				user_info.each_hash{|h| puts h['id']}
			end
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		end
	end

	def close_db
		@db.close if @db
	end





end