class CreateChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :children do |t|
      t.integer :user_id, null: false
      t.date :birth_date, null: false
      t.integer :sex, null: false

      t.timestamps
    end
  end
end
