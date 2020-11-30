class AddDurationToMidpointToMidwayParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column(:midway_participants, :duration_to_midpoint, :string)
  end
end
