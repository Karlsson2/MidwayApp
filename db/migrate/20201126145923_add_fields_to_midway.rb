class AddFieldsToMidway < ActiveRecord::Migration[6.0]
  def change
    add_column(:midways, :time_option, :string)
    add_column(:midways, :future_time, :datetime)
    remove_column(:midways, :arrival_time, :string)
  end
end
