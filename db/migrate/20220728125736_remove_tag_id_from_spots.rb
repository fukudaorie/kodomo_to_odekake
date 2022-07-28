class RemoveTagIdFromSpots < ActiveRecord::Migration[6.1]
  def change
    remove_column :spots, :tag_id, :integer
  end
end
