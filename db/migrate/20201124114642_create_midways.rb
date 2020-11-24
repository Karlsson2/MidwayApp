class CreateMidways < ActiveRecord::Migration[6.0]
  def change
    create_table :midways do |t|
      t.string :midpoint
      t.string :venue
      t.references :user, null: false, foreign_key: true
      t.time :arrival_time

      t.timestamps
    end
  end
end
