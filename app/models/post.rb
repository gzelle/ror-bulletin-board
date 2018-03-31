class Post < ApplicationRecord
	belongs_to :boardthread, counter_cache: :post_count
	belongs_to :user, counter_cache: :post_count


	def post_user(user_id)
		@user = User.find(user_id)
	end

end
