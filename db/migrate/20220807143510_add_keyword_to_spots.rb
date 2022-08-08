class AddKeywordToSpots < ActiveRecord::Migration[6.1]
  def change
    add_column :spots, :keyword, :string
  end
end
