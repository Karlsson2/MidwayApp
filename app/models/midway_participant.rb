class MidwayParticipant < ApplicationRecord
  belongs_to :midway
  belongs_to :user, optional: true
  belongs_to :guest, optional: true
end
