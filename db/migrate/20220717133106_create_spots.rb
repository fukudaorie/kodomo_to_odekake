class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
