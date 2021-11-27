class Organization < ApplicationRecord
  has_one :shift
  has_many :user_org
end
