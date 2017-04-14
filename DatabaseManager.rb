require 'sqlite3'
class DatabaseManager

	def initialize
		@db = SQLite3::Database.open "test.db"
	end

	def set_up
		begin
			# @db = SQLite3::Database.open "test.db"
			@db.transaction
			@db.execute "DROP TABLE IF EXISTS server"
			@db.execute "DROP TABLE IF EXISTS users"
			@db.execute "CREATE TABLE server
						(
							id INT,
							clientID INT,
							ip TEXT,
							port INT,
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
		ensure
			# @db.close
		end
	end

	def add_server(ip,port,clientID)
		begin
			# @db = SQLite3::Database.open "test.db"
			@db.transaction
			stm=@db.prepare "INSERT INTO server(id,clientID,ip,port,available)
			SELECT IFNULL(MAX(id), 0) + 1,?,?,?,1 from users"

			stm.bind_param 1, clientID
			stm.bind_param 2, ip
			stm.bind_param 3, port

			stm.execute
			stm.close
			@db.commit
			# @db.close()
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		end
	end

	def get_connected_ips
		arr = Array.new
		begin
			# @db = SQLite3::Database.open "test.db"
			# @db.transaction
			stm=@db.prepare 'select ip from server where available=1'
			ip_info = stm.execute


			while row =ip_info.next do
				# puts row.join "\s"
				arr.push(row[0].chomp)
			end
				
			ip_info.close
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
			@db.rollback
		ensure
			@db.close
		end
		return arr

	end

	def get_user(username, password)
		str = ""
		begin
			p "here -2"
			dbm = SQLite3::Database.open "test.db"
			username=username.to_s
			password=password.to_s
			puts username

			puts password
			user_info = dbm.execute	"select * from users where username = \"#{username}\" and password = \"#{password}\""

			p "here -1"
			# stm.bind_param 1, username
			# stm.bind_param 2, password
			# p stm
			# user_info = stm.execute
			# user_info.each_hash{|h| puts h['username']}
			# puts user_info.eof?
			p user_info
			user_res=user_info.next
			p user_res
			if user_res != nil
				p "here 2"
				str=str+user_res[0]+" "
				str=str+user_res[1]+" "
				str=str+user_res[2]+" "
				str=str+user_res[3]+" "
				str=str+user_res[4]+" "
				str=str+user_res[5]+" "
				str=str+user_res[6]+" "
				p str
				
			end
		rescue SQLite3::Exception => e
			puts "Exception occurred1"
			puts e
		ensure
			# @db.close
		end
		p str
		return str.chomp
	end


	def add_user(ip, username, password, online)
   	puts " adding user"
   		begin
   			# if !@db 
   			# 	@db = SQLite3::Database.open "test.db"
   			# end
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
			# @db = SQLite3::Database.open "test.db"
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
		# if !@db 
  #  			@db = SQLite3::Database.open "test.db"
  #  		end
		u = get_user(user)
		if u
			user  = u
		end
		
	end


	def close
		@db.close
	end

end

# dbm = DatabaseManager.new 
# dbm.set_up
# # dbm.add_server(1,2,3)
# dbm.add_server(4,1,3)
# dbm.get_connected_ips
# sm = ServerManager.new
