class Midway < ApplicationRecord
  belongs_to :user
  has_many :midway_participants
end
