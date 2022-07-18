class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :spot_id, null: false
      t.text :body, null: false
      t.float :star, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
