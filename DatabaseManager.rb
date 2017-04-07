require 'sqlite3'
require_relative 'User'
class DatabaseManager

	def initialize

	end

	def set_up
		begin
			@db = SQLite3::Database.open "test.db"
			@db.transaction
			@db.execute "DROP TABLE IF EXISTS server"
			@db.execute "DROP TABLE IF EXISTS users"
			@db.execute "CREATE TABLE server
						(
							id INT,
							clientID INT,
							ip TEXT
						)"
			@db.execute "CREATE TABLE users
						(
							id INT,
							ip TEXT,
							league TEXT,
							wins INT,
							losses INT,
							username TEXT,
							password TEXT
						)"
			@db.commit
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
			@db.rollback
		end
	end

	def get_user(user)
		begin
			@db = SQLite3::Database.open "test.db"
			stm = @db.prepare 'select * from users where username=? and password =?'
			stm.bind_param 1, user.get_username
			stm.bind_param 2, user.get_password
			user_info = stm.execute
			# puts user_info.eof?
			user_res=user_info.next
			if user_res != nil
				user.set_id(user_res[0])
				user.set_ip(user_res[1])
				user.set_league(user_res[2])
				user.set_wins(user_res[3])
				user.set_losses(user_res[4])
				user.set_username(user_res[5])
				user.set_password(user_res[6])
				return user
			end
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		end
		return false
	end


	def add_user(user)
		# puts user.class
		begin
			@db = SQLite3::Database.open "test.db"
			@db.transaction
			stm=@db.prepare "INSERT INTO users(id,ip,league,wins,losses,username,password)
			SELECT IFNULL(MAX(id), 0) + 1,?,0,0,0,?,? from users"

			stm.bind_param 1, user.get_ip
			stm.bind_param 2, user.get_username
			stm.bind_param 3, user.get_password

			stm.execute
			@db.commit
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		end
		
	end



	def close
		@db.close
	end

end

# sm = ServerManager.new
