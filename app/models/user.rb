class User < ApplicationRecord
  include Clearance::User
  has_many :boardthreads
  has_many :posts
  attribute :role, :integer, default: 0
  attribute :status, :integer, default: 0

  before_update :password_optional?

  enum role: %w(poster moderator administrator)
  enum status: %w(normal banned)
  enum gender: %w(male female unspecified)

  validates :name, :email, :about, :birthdate, :hometown, :present_location, presence: true

  def ban(user)
    user.status = 1
    user.save
  end

  def unban(user)
    user.status = 0
    user.save
  end

  private
    def password_optional?
      true
    end

end
