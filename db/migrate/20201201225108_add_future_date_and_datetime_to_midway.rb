class AddFutureDateAndDatetimeToMidway < ActiveRecord::Migration[6.0]
  def change
    remove_column(:midways, :future_time, :datetime)
    add_column(:midways, :future_time, :time)
    add_column(:midways, :future_date, :date)
    add_column(:midways, :future_datetime, :datetime)
  end
end
