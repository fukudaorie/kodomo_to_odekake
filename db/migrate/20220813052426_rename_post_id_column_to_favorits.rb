class RenamePostIdColumnToFavorits < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorits, :post_id, :spot_id
  end
end
