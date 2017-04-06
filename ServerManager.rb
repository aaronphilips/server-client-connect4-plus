require 'sqlite3'

class ServerManager

	def initialize
		begin
			@db = SQLite3::Database.open "test.db"
			@db.transaction
			@db.execute "DROP TABLE IF EXISTS server"
			@db.execute "DROP TABLE IF EXISTS clients"
			@db.execute "CREATE TABLE server
						(
							id INT,
							client1ID INT,
							client2ID INT,
							ip TEXT
						)"
			@db.execute "CREATE TABLE clients
						(
							id INT,
							ip TEXT,
							league TEXT,
							wins INT,
							losses INT
						)"
			@db.commit
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
			@db.rollback
		ensure
			@db.close if @db
		end
	end

end

sm = ServerManager.new
