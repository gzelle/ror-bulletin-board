class Post < ApplicationRecord
	belongs_to :boardthread
	belongs_to :user

	def post_user(user_id)
		@user = User.find(user_id)
	end
end
