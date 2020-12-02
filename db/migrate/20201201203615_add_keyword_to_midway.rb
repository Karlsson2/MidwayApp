class AddKeywordToMidway < ActiveRecord::Migration[6.0]
  def change
    add_column(:midways, :keyword, :string)
  end
end
