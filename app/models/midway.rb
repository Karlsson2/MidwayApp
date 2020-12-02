class Midway < ApplicationRecord
  CATEGORY = [['Restaurant', 'restaurant'], ['Pub', 'bar'], ['Cinema', 'movie_theater' ], ['Park', 'park'], ['Art Gallery', 'art_gallery'], ['Museum', 'museum'], ['Nightclub', 'night_club'] ]
  belongs_to :user
  belongs_to :venue
  has_many :midway_participants, dependent: :destroy
end
