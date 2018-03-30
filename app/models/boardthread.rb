class Boardthread < ApplicationRecord
	belongs_to :board, counter_cache: :thread_count
  	belongs_to :user
  	has_many :posts

  	def latest_post
  		self.posts.order("created_at").last
  	end

  	def sort_posts
  		self.posts.order("created_at")
  	end

  	def find_user(user_id)
      User.find(user_id)
    end

end
