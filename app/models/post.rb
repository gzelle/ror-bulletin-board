class Post < ApplicationRecord
	belongs_to :boardthread
	belongs_to :user

end
