class AddUserIdToSpots < ActiveRecord::Migration[6.1]
  def change
    add_column :spots, :user_id, :integer, null: false
    add_index :spots, :user_id
  end
end
