class Board < ApplicationRecord
	belongs_to :topic
	has_many :boardthreads

	def postcount
    	@boardthreads = self.boardthreads
		@postcount = @boardthreads.inject(0) { |sum, b| sum + b.post_count }
	end
end
