class User < ApplicationRecord
  include Clearance::User
  has_many :boardthreads
  has_many :posts

  enum role: %w(poster moderator administrator)
  enum status: %w(normal banned)

end
