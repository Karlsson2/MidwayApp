class AddLatAndLongToUser < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :lat, :string)
    add_column(:users, :lng, :string)
  end
end
