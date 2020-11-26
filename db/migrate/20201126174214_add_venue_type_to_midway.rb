class AddVenueTypeToMidway < ActiveRecord::Migration[6.0]
  def change
    add_column(:midways, :venue_type, :string)
  end
end
