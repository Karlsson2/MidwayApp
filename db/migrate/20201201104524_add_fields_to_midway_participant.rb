class AddFieldsToMidwayParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column(:midway_participants, :walk_to_midpoint, :string)
    add_column(:midway_participants, :drive_to_midpoint, :string)
  end
end
