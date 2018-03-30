class User < ApplicationRecord
  include Clearance::User
  has_many :boardthreads
  has_many :posts
  attribute :role, :integer, default: 0
  attribute :status, :integer, default: 0

  before_update :password_optional?

  enum role: %w(poster moderator administrator)
  enum status: %w(normal banned)

  validates :name, :email, :about, :birthdate, :hometown, :present_location, presence: true

  private
    def password_optional?
      true
    end

    def ban(user)
      if current_user.moderator? || current_user.administrator?
        if user.normal?
          user.status = 1
          user.save
        end
      end
    end

    def unban(user)
      if current_user.moderator? || current_user.administrator?
        if user.banned?
          user.status = 0
          user.save
        end
      end
    end

end
