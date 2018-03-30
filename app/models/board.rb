class Board < ApplicationRecord
	belongs_to :topic
	has_many :boardthreads

	def sort_threads
		posts = self.boardthreads.posts
		bthreads = Boardthread.includes(:posts).order("posts.created_at")
	end
end
