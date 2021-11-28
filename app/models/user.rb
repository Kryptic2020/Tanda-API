class User < ApplicationRecord  
  has_many :user_org
  has_many :shifts
  has_secure_password

  #Validations
  validates :username, presence: true, uniqueness: false, length: {minimum: 3, too_short: "3 is the minimum number of caracter"}  
  validates :email, presence: true, uniqueness: true

  #data santization
  before_save :remove_whitespace

   private 

  # remove any whitespace before saving user
  def remove_whitespace
    self.email = self.email.strip
    self.username = self.username.strip
  end       
end
