class Boardthread < ApplicationRecord
	belongs_to :board, counter_cache: :thread_count
  	belongs_to :user
  	has_many :posts

end
