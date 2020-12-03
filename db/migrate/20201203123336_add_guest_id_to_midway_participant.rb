class AddGuestIdToMidwayParticipant < ActiveRecord::Migration[6.0]
  def change
    add_reference(:midway_participants, :guest, foreign_key: true)
  end
end
