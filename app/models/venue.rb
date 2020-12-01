class Venue < ApplicationRecord
  has_many :midways, dependent: :destroy
end
