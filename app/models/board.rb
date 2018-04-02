class Board < ApplicationRecord
	belongs_to :topic
	has_many :boardthreads

	def postcount
    	@boardthreads = self.boardthreads
    	@boardthreads.sum("post_count")
		#@postcount = @boardthreads.inject(0) { |sum, b| sum + b.post_count }
	end

	def sortthreads(type)
		board_id = self.id
		Boardthread.find_by_sql("SELECT * FROM boardthreads bthread WHERE bthread.board_id = #{board_id} AND bthread.threadtype = #{type} ORDER BY (SELECT created_at FROM posts p WHERE p.boardthread_id = bthread.id ORDER BY created_at DESC) DESC");
	end
end
