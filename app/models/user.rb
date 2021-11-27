class User < ApplicationRecord
  has_many :user_org
  has_many :shifts
end
