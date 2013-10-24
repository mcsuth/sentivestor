class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save :create_remember_token

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  def create_remember_token
  	self.remember_token = SecureRandom.urlsafe_base64
  end

has_many :stocks

end
