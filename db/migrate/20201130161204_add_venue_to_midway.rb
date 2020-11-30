class AddVenueToMidway < ActiveRecord::Migration[6.0]
  def change
    remove_column(:midways, :venue, :string)
    add_reference(:midways, :venue, foreign_key: true)
  end
end
