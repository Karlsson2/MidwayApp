class AddLatAndLongToGuest < ActiveRecord::Migration[6.0]
  def change
    add_column(:guests, :lat, :string)
    add_column(:guests, :lng, :string)
  end
end
