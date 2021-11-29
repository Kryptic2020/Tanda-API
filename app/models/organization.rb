class Organization < ApplicationRecord
  has_one :shift
  has_many :user_orgs
  has_many :users, through: :user_orgs
end
