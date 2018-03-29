class Board < ApplicationRecord
	belongs_to :topic
	has_many :boardthreads
end
