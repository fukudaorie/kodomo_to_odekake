class CreateSpotTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :spot_tag_relations do |t|
      t.references :spot, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
