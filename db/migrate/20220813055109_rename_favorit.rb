class RenameFavorit < ActiveRecord::Migration[6.1]
  def change
    rename_table :favorits, :favorites
  end
end
