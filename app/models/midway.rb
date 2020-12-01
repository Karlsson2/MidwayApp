class Midway < ApplicationRecord
  belongs_to :user
  belongs_to :venue
  has_many :midway_participants, dependent: :destroy
end
