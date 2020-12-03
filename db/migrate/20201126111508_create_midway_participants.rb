class CreateMidwayParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :midway_participants do |t|
      t.references :midway, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
