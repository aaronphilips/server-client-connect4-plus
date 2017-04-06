class Client

	def initialize

	end


	def get_server_manager_info
		begin 
			@db = SQLite3::Database.open "test.db"
			@db.transaction
			res = @db.query('select * from server')
			res.each_hash{|h| puts h['columnName']}
		rescue SQLite3::Exception => e
			puts "Exception occurred"
			puts e
		ensure
			res.close if res
		end
	end
end