class AddChoiceToMidway < ActiveRecord::Migration[6.0]
  def change
    add_column(:midways, :choice, :string)
  end
end
