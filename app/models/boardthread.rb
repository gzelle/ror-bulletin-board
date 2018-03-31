class Boardthread < ApplicationRecord
	belongs_to :board, counter_cache: :thread_count
	belongs_to :user
	has_many :posts
  before_save :postcount

	attribute :post_count, :integer, default: 0
	enum status: %w(unlocked locked)
	enum threadtype: %w(sticky nonsticky)

	def lock(boardthread)
    boardthread.status = 1
    boardthread.save
  end

  def unlock(boardthread)
    boardthread.status = 0
    boardthread.save
  end

  def latest_post
		self.posts.order("created_at").last
	end

	def sort_posts
		self.posts.order("created_at")
	end

	def find_user(user_id)
    User.find(user_id)
  end

  def boardname
  	board = Board.find(self.board_id)
  	return board.name
  end

  def postcount
    if self.post_count
      self.post_count
    else
      0
    end
  end
  
end
