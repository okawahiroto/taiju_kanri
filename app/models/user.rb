class User < ActiveRecord::Base
  before_save { self.email.downcase! }

  validates :name,
    presence: true,
    length: { maximum: 50 }
  validates :email,
    presence: true,
    email_format: { message: 'email format is invalid' },
    uniqueness: true
  validates :password,
    length: { minimum: 6 }
  
  has_secure_password
end
