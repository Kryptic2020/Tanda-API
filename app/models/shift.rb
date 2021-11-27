class Shift < ApplicationRecord
  has_many :breaks
  belongs_to :organization
  belongs_to :user
end
