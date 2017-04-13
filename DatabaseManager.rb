require 'sqlite3'
class DatabaseManager

	def initialize
		@db = SQLite3::Database.open "test.db"
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
							ip TEXT,
							available INT
						)"
			@db.execute "CREATE TABLE users
						(
							id INT,
							ip TEXT,
							league TEXT,
							wins INT,
							losses INT,
							username TEXT,
							password TEXT,
							online INT
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
			if !@db
   				@db = SQLite3::Database.open "test.db"
   			end
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
			puts "Exception occurred1"
			puts e
		end
		return false
	end


	def add_user(ip, username, password, online)
   	puts " adding user"
   		begin
   			if !@db 
   				@db = SQLite3::Database.open "test.db"
   			end
			@db.transaction
			stm=@db.prepare "INSERT INTO users(id,ip,league,wins,losses,username,password, online)
			SELECT IFNULL(MAX(id), 0) + 1,?,0,0,0,?,?,? from users"

			stm.bind_param 1, ip
			stm.bind_param 2, username
			stm.bind_param 3, password
			stm.bind_param 4, online

			stm.execute
			# stm.close
			@db.commit
			# @db.close()
			# puts "db closed"
		rescue SQLite3::Exception => e
			puts "Exception occurred2"
			puts e
		ensure
    		stm.close if stm
    		# @db.close if @db
		end   
	end

	def get_servers
		begin
			@db = SQLite3::Database.open "test.db"
			# @db.transaction
			  online_servers = @db.query('select ip from server where available = 1')

			# stm=@db.prepare "select ip from server where available = 1 "

			# online_servers = stm.execute
			# @db.commit
			  ip_array = Array.new
			  online_servers.each_hash {|h| ip_array << h['ip']}

			return ip_array
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		ensure
    		# stm.close if stm
    		# @db.close if @db
		end  
	end

	def check_user_exists(user)
		if !@db 
   			@db = SQLite3::Database.open "test.db"
   		end
		u = get_user(user)
		if u
			user  = u
		end
		
	end


	def close
		@db.close
	end

end

# sm = ServerManager.new
