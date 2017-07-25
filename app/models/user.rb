class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save :email_downcase

  validates :name, presence: true, length:
    {maximum: Settings.name_length_max.to_i}
  validates :email, presence: true, length:
    {maximum: Settings.email_length_max.to_i},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length:
    {minimum: Settings.email_length_min.to_i}

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end
  end

  private

  def email_downcase
    email.downcase!
  end
end
